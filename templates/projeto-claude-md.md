# Projeto conduzido pelo AI-SQUAD

Este arquivo é lido automaticamente pelo Claude Code sempre que uma sessão abre nesta pasta. Ele existe para o AI-SQUAD acordar sozinho e retomar o trabalho sem que ninguém precise pedir.

## O que fazer ao abrir esta pasta

**Invoque a skill `ai-squad` imediatamente, antes de responder qualquer coisa.**

O builder vai ler `.ai-squad/estado.json`, entender em que fase o projeto está, e continuar de onde parou.

Não improvise sobre este projeto sem carregar o AI-SQUAD antes. O estado tem meses de decisão acumulada que não estão nesta conversa.

## Onde está cada coisa

| Caminho | Conteúdo |
|---------|----------|
| `.ai-squad/estado.json` | fonte da verdade do projeto, sempre atualizada |
| `.ai-squad/estado.js` | o mesmo conteúdo, lido pelo painel no navegador |
| `.ai-squad/decisoes.md` | o porquê de cada decisão tomada, em ordem |
| `.ai-squad/dashboard.html` | o painel visual, para abrir no navegador |
| `01-discovery/` | visão, estratégia, riscos, PRD, protótipo, plano técnico |
| `02-delivery/` | documentação da construção |
| `03-qualidade/` | relatórios de qualidade, auditoria de segurança e evals |
| `04-go-to-market/` | plano de lançamento e material de divulgação |
| `05-ciclo-de-vida/` | análises, decisões e evolução pós-lançamento |
| `produto/` | o código do produto |

## Regras deste projeto

1. Português do Brasil com acentuação correta em tudo. Nunca use travessão.
2. Todo HTML sai com o texto acentuado escapado, nunca com o byte cru. Rode o normalizador do AI-SQUAD depois de escrever ou editar qualquer HTML.
3. O repositório é privado. Nunca torne público sem pedido explícito da dona do produto do projeto.
4. Antes de encerrar qualquer sessão, atualize o estado, o painel, a documentação e suba para o GitHub.
5. Manutenção você faz e depois conta. Evolução passa por o builder antes.
