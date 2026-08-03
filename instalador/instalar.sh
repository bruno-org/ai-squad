#!/usr/bin/env bash
# Instalador do AI-SQUAD para macOS e Linux.
#
# O que ele faz:
#   1. copia o AI-SQUAD para ~/.ai-squad (vendor, templates, ferramentas)
#   2. copia as skills para ~/.claude/skills, que e onde o Claude Code as encontra
#   3. cria o registro global de projetos
#   4. confere as dependencias minimas e diz o que falta
#
# Ele NAO instala dependencia. Quem instala e a fase 0 do proprio AI-SQUAD,
# explicando cada passo para quem esta usando. Aqui so verificamos.
#
# Uso:  bash instalar.sh
#       bash instalar.sh /caminho/de/destino
#
# O destino existe para poder instalar numa pasta de teste sem tocar na maquina.
# Sem argumento, instala no lugar de sempre.

set -euo pipefail

ORIGEM="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DESTINO="${1:-$HOME}"
CASA="${DESTINO}/.ai-squad"
SKILLS="${DESTINO}/.claude/skills"

echo ""
echo "  AI-SQUAD"
echo "  Instalando a partir de: ${ORIGEM}"
echo ""

# ---- 1. sistema ------------------------------------------------------------
case "$(uname -s)" in
  Darwin)            SISTEMA="macOS";   GERENCIADOR="brew" ;;
  Linux)             SISTEMA="Linux";   GERENCIADOR="apt"  ;;
  MINGW*|MSYS*|CYGWIN*) SISTEMA="Windows"; GERENCIADOR="winget" ;;
  *)                 SISTEMA="$(uname -s)"; GERENCIADOR="" ;;
esac
echo "  Sistema detectado: ${SISTEMA}"
if [ "${SISTEMA}" = "Windows" ]; then
  echo "  (No Windows, o caminho recomendado e o instalar.ps1. Este script funciona,"
  echo "   mas o PowerShell lida melhor com os caminhos do sistema.)"
fi

# ---- 2. copiar o sistema ---------------------------------------------------
mkdir -p "${CASA}"
for parte in vendor templates ferramentas; do
  if [ -d "${ORIGEM}/${parte}" ]; then
    rm -rf "${CASA:?}/${parte}"
    cp -R "${ORIGEM}/${parte}" "${CASA}/${parte}"
    echo "  Copiado: ${parte}"
  fi
done

# ---- 3. instalar as skills -------------------------------------------------
mkdir -p "${SKILLS}"
CONTA=0
for pasta in "${ORIGEM}"/skills/*/; do
  [ -d "${pasta}" ] || continue
  nome="$(basename "${pasta}")"
  rm -rf "${SKILLS:?}/${nome}"
  cp -R "${pasta}" "${SKILLS}/${nome}"
  CONTA=$((CONTA + 1))
done
echo "  Skills instaladas: ${CONTA} em ${SKILLS}"

# ---- 4. registro global de projetos ----------------------------------------
if [ ! -f "${CASA}/projetos.json" ]; then
  echo '{"projetos": []}' > "${CASA}/projetos.json"
  echo "  Registro de projetos criado."
else
  echo "  Registro de projetos preservado."
fi

# ---- 5. conferir dependencias ----------------------------------------------
echo ""
echo "  Dependencias minimas:"
FALTA=""
checar() {
  if command -v "$1" >/dev/null 2>&1; then
    printf "    ok      %-8s %s\n" "$1" "$(${1} --version 2>&1 | head -n1)"
  else
    printf "    falta   %-8s\n" "$1"
    FALTA="${FALTA} $1"
  fi
}
checar git
checar node
# no macOS e no Linux o binario e python3; no Git Bash do Windows e python
if command -v python3 >/dev/null 2>&1; then
  checar python3
else
  checar python
fi
if command -v claude >/dev/null 2>&1; then
  printf "    ok      %-8s\n" "claude"
else
  printf "    falta   %-8s\n" "claude"
  FALTA="${FALTA} claude"
fi

echo ""
if [ -n "${FALTA}" ]; then
  echo "  Falta instalar:${FALTA}"
  echo "  Nao precisa fazer nada agora. Abra o Claude Code e diga que quer criar"
  echo "  um produto: o AI-SQUAD instala o que faltar, explicando cada passo."
  if [ -n "${GERENCIADOR}" ]; then
    echo "  (Se preferir adiantar, o gerenciador deste sistema e o ${GERENCIADOR}.)"
  fi
else
  echo "  Tudo pronto."
fi

echo ""
echo "  Para começar: abra o Claude Code e diga o que você quer criar."
echo ""
