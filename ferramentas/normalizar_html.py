#!/usr/bin/env python3
"""
Normalizador de HTML do AI-SQUAD.

Converte todo caractere nao-ASCII de um arquivo HTML para a forma escapada
correta de acordo com o contexto sintatico onde ele aparece:

  - dentro de <script>: escape JavaScript  \\uXXXX
  - dentro de <style>:  escape CSS         \\XXXXXX
  - no HTML propriamente dito: entidade nomeada, ou numerica quando nao houver nome

Motivo: em algum ponto entre o arquivo e a tela, algum programa pode ler os bytes
UTF-8 como se fossem outra codificacao e a acentuacao vira lixo. Fonte em ASCII
puro e imune a isso.

A acentuacao continua obrigatoria no que a pessoa le. O que muda e a forma de
escrever no arquivo, nunca o resultado na tela.

Travessao e proibido: o script falha e aponta a linha, porque a correcao e
reescrever a frase, nunca virar entidade.

Uso:
    python normalizar_html.py arquivo.html [outro.html ...]
    python normalizar_html.py --verificar arquivo.html    (so verifica, nao altera)
"""

import re
import sys
import html.entities

TRAVESSOES = {
    "—": "travessao (em-dash)",
    "–": "travessao (en-dash)",
}

# Entidades nomeadas, preferidas por serem legiveis: &ccedil; diz mais que &#x00E7;.
# codepoint2name ja e {codepoint: nome}, entao usamos direto. Inverter aqui foi um
# bug antigo que fazia o dicionario nunca casar e derrubava tudo para o numerico.
NOMES = dict(html.entities.codepoint2name)


def escapa_html(ch: str) -> str:
    cp = ord(ch)
    nome = NOMES.get(cp)
    return f"&{nome};" if nome else f"&#x{cp:04X};"


def escapa_js(ch: str) -> str:
    cp = ord(ch)
    if cp > 0xFFFF:  # fora do plano basico, precisa de par substituto
        cp -= 0x10000
        return f"\\u{0xD800 + (cp >> 10):04X}\\u{0xDC00 + (cp & 0x3FF):04X}"
    return f"\\u{cp:04X}"


def escapa_css(ch: str) -> str:
    return f"\\{ord(ch):06X}"


def fatiar(texto: str, caminho: str = ""):
    """Divide o documento em blocos (tipo, inicio, fim) por contexto sintatico."""
    baixo = caminho.lower()
    if baixo.endswith((".js", ".mjs", ".cjs")):
        return [("js", 0, len(texto))]
    if baixo.endswith(".css"):
        return [("css", 0, len(texto))]

    marcas = []
    for tag, tipo in (("script", "js"), ("style", "css")):
        padrao = re.compile(rf"<{tag}\b[^>]*>(.*?)</{tag}>", re.S | re.I)
        for m in padrao.finditer(texto):
            marcas.append((tipo, m.start(1), m.end(1)))
    # Ordena pelo inicio e, em empate, do bloco mais externo para o mais interno.
    marcas.sort(key=lambda x: (x[1], -x[2]))

    blocos, pos = [], 0
    for tipo, ini, fim in marcas:
        # Uma tag <style> dentro de uma string de <script> (ou o contrario) gera
        # marcas sobrepostas. Sem esta guarda, o trecho era consumido duas vezes
        # e o arquivo saia com texto duplicado, corrompido numa unica passada.
        if ini < pos:
            continue
        if ini > pos:
            blocos.append(("html", pos, ini))
        blocos.append((tipo, ini, fim))
        pos = fim
    if pos < len(texto):
        blocos.append(("html", pos, len(texto)))
    return blocos


def normalizar(texto: str, caminho: str = "") -> str:
    escapadores = {"html": escapa_html, "js": escapa_js, "css": escapa_css}
    saida = []
    for tipo, ini, fim in fatiar(texto, caminho):
        escapar = escapadores[tipo]
        saida.append("".join(escapar(c) if ord(c) > 127 else c for c in texto[ini:fim]))
    return "".join(saida)


def achar_travessao(texto: str):
    achados = []
    for i, linha in enumerate(texto.splitlines(), 1):
        for ch, nome in TRAVESSOES.items():
            if ch in linha:
                achados.append((i, nome, linha.strip()[:80]))
    return achados


def sobrou_nao_ascii(texto: str):
    achados = []
    for i, linha in enumerate(texto.splitlines(), 1):
        for ch in linha:
            if ord(ch) > 127:
                achados.append((i, ch, hex(ord(ch))))
    return achados


def processar(caminho: str, apenas_verificar: bool) -> bool:
    with open(caminho, "r", encoding="utf-8") as f:
        original = f.read()

    travessoes = achar_travessao(original)
    if travessoes:
        print(f"FALHOU {caminho}: travessão encontrado, reescreva a frase.")
        for linha, nome, trecho in travessoes:
            print(f"   linha {linha}: {nome} em: {trecho}")
        return False

    if apenas_verificar:
        restos = sobrou_nao_ascii(original)
        if restos:
            print(f"FALHOU {caminho}: {len(restos)} caractere(s) não-ASCII.")
            for linha, ch, cod in restos[:10]:
                print(f"   linha {linha}: {ch!r} ({cod})")
            return False
        print(f"OK {caminho}: ASCII puro.")
        return True

    novo = normalizar(original, caminho)
    restos = sobrou_nao_ascii(novo)
    if restos:
        print(f"FALHOU {caminho}: sobrou caractere não-ASCII após normalizar.")
        for linha, ch, cod in restos[:10]:
            print(f"   linha {linha}: {ch!r} ({cod})")
        return False

    if novo != original:
        with open(caminho, "w", encoding="utf-8", newline="") as f:
            f.write(novo)
        convertidos = sum(1 for c in original if ord(c) > 127)
        print(f"OK {caminho}: {convertidos} caractere(s) convertido(s).")
    else:
        print(f"OK {caminho}: ja estava em ASCII puro.")
    return True


def main() -> int:
    args = sys.argv[1:]
    apenas_verificar = "--verificar" in args
    alvos = [a for a in args if not a.startswith("--")]

    if not alvos:
        print(__doc__)
        return 2

    # Lista, nao gerador: all() com gerador para no primeiro False e os arquivos
    # seguintes nunca seriam processados, sem o usuario perceber.
    resultados = [processar(a, apenas_verificar) for a in alvos]
    return 0 if all(resultados) else 1


if __name__ == "__main__":
    raise SystemExit(main())
