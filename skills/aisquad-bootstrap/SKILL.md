---
name: aisquad-bootstrap
description: Fase 0 do AI-SQUAD. Prepara a máquina e cria o projeto novo. Use quando o AI-SQUAD identificar que é um projeto do zero, quando faltar dependência mínima para trabalhar, ou quando precisar criar a pasta, o estado e o dashboard de um projeto novo.
---

A primeira coisa que vive no AI-SQUAD acontece aqui. Se isso emperrar, não existe fase 1.

O builder não instala nada, não configura nada, não abre terminal. O builder no máximo faz login em uma tela que você abre para ele.

## 1. Leia a máquina

Descubra o que existe antes de tocar em qualquer coisa:

- Sistema operacional e versão. macOS e Windows são os alvos; trate Linux como bônus.
- Gerenciador de pacote disponível: `brew` no macOS, `winget` no Windows.
- O que já está instalado: `node --version`, `git --version`, `python3 --version`, `gh --version`.
- MCPs conectados na sessão, skills disponíveis, ferramentas extras.

Anote o que encontrou. O que for além do perfil-base é ganho opcional, e **nunca** pode virar pré-requisito de etapa nenhuma.

## 2. Instale só o que faltar, e só quando faltar

**A a máquina pode já estar pronta.** Se a checagem do passo 1 mostrou tudo instalado, não instale nada, não avise nada, siga direto para o passo 3. Ficar instalando o que já existe é perda de o tempo do builder e ruído na tela.

**E o que falta você instala na hora em que a necessidade aparece, não antes.** Cada peça tem um gatilho:

| Peça | Instale quando | macOS | Windows |
|------|----------------|-------|---------|
| git | sempre, é o primeiro passo real | `brew install git` | `winget install Git.Git` |
| MCP do GitHub | for criar o repositório | `claude mcp add` | igual |
| Playwright | precisar abrir tela para o builder autenticar | `npx playwright install chromium` | igual |
| Node.js | o produto escolhido no Discovery precisar | `brew install node` | `winget install OpenJS.NodeJS.LTS` |
| Python 3 | for gerar documento ou rodar script que peça | `brew install python` | `winget install Python.Python.3.13` |

Se o builder já tem conta no GitHub e autenticada, o Playwright pode nem ser necessário no bootstrap: deixe para quando aparecer a primeira tela de login de verdade. Baixar navegador de 300 MB por precaução, para talvez não usar, é o contrário de conduzir bem.

Quando instalar, diga o que está instalando e por quê, em uma linha: "instalando o Git, que é o programa que guarda o histórico do seu projeto e permite voltar atrás quando algo quebra".

Playwright demora, porque baixa um navegador inteiro. Avise antes, senão o builder acha que travou.

Se uma instalação falhar, não siga fingindo que deu certo. Diga o que falhou, tente o caminho alternativo, e se não houver, registre em `pendencias_para_ela` com a instrução exata do que precisa fazer.

**Esta regra vale para o sistema todo, não só para esta fase.** Qualquer fase que precise de uma ferramenta confere se existe e instala apenas se faltar, no momento do uso.

## 3. Conta no GitHub

Se `gh auth status` mostrar conta ativa, siga.

Se não houver conta, conduza pelo Playwright: abra a tela, explique o que é o GitHub em uma frase ("é onde o código do seu produto fica guardado, tipo um Google Drive feito para programa"), peça só que crie a conta ou faça login, e assuma de volta assim que terminar.

O builder autentica. Você faz o resto: autorizar o CLI, configurar acesso, criar o que precisar.

## 4. Descubra o produto, no essencial

Ainda não é Discovery. São três perguntas, uma de cada vez, só para dar nome e lugar às coisas:

1. O que você quer criar? Pode falar do jeito que vier.
2. Que nome você quer dar para essa pasta? Se o builder não souber, sugira um a partir do que falou.
3. É algo para vender ou usar por fora, ou é para uso interno seu ou da sua empresa?

Nada além disso. Aprofundar aqui atropela o Discovery.

## 5. Crie o projeto

Na área de trabalho do builder, uma pasta por projeto:

```
<Área de Trabalho>/<nome-do-projeto>/
  .ai-squad/
    estado.json
    estado.js
    decisoes.md
    dashboard.html
    prodman-logo.png
  01-discovery/
  02-delivery/
  03-qualidade/
  04-go-to-market/
  05-ciclo-de-vida/
  produto/
  CLAUDE.md
  README.md
  .gitignore
```

O caminho da área de trabalho muda por sistema e por idioma do Windows. Descubra o real, não presuma: no macOS é `~/Desktop`; no Windows pode ser `~/Desktop`, `~/Área de Trabalho` ou um caminho redirecionado para OneDrive. Confira antes de escrever.

`produto/` é onde o código vai morar. As pastas numeradas guardam os documentos de cada fase.

**Nomenclatura dos documentos**: `AAAA-MM-DD-assunto-em-minusculo.md`. Data primeiro para ordenar sozinho.

Copie a pasta `~/.ai-squad/templates/dashboard/` inteira para `.ai-squad/`, com os três arquivos: `dashboard.html`, `estado.js` e `prodman-logo.png`. O painel lê os dois últimos do lado dele, então nenhum pode ficar para trás.

Copie também `~/.ai-squad/templates/projeto-claude-md.md` para `CLAUDE.md` na raiz do projeto. É ele que faz o sistema acordar sozinho quando abrir o Claude Code ali de novo.

Depois crie os quatro arquivos que nascem com o projeto:

**`estado.json`**: os quatro riscos em `alto`, `fase_atual` em `bootstrap`, as seis fases presentes com `nao_iniciada`, e os dados do projeto que você acabou de descobrir. Gere `estado.js` a partir dele.

**`decisoes.md`**: comece com o cabeçalho e a primeira entrada, registrando a criação do projeto e o que disse que queria construir. Este arquivo é lido no início de toda sessão futura; se ele não existir, o sistema abre cego.

**`README.md`** na raiz: nome do produto, uma frase do que ele é e para quem, em que fase está, e onde encontrar cada coisa. Escrito para o builder, em português claro, sem termo técnico. É o que vê se abrir a pasta pelo explorador de arquivos.

**`.gitignore`**: ignore `node_modules/`, `.env`, `.env.*`, `dist/`, `build/`, `.DS_Store` e qualquer arquivo de credencial. Segredo que entra no histórico do git não sai mais, e o repositório é do builder para sempre.

## 6. Registre o projeto na máquina

Adicione o projeto em `~/.ai-squad/projetos.json`, com nome, caminho, fase atual e data. Crie o arquivo se não existir.

É isso que permite o builder falar do produto em qualquer sessão, de qualquer pasta, e o sistema achar o projeto sem o builder saber onde ele está.

## 7. Repositório

Crie no GitHub, **privado**, com o nome do projeto. Primeiro commit com a estrutura.

Não configure publicação automática agora. Durante o Discovery o repositório guarda documento e protótipo, e `main` só passa a publicar quando existir produto. Isso é decidido no Delivery.

## 8. Entregue e siga

Mostre o dashboard: abra o arquivo no navegador do builder para ele ver com os próprios olhos, e explique que pode abrir aquilo quando quiser para saber onde o projeto está.

Diga em uma frase o que vem agora, e invoque `aisquad-discovery`.

Não pare para o builder responder se pode continuar. O builder não sabe o que vem depois. Você sabe. Conduza.

## Antes de virar a fase

Nesta ordem, sem pular nenhum:

1. `fases.bootstrap.status = "concluida"`, ou `"concluida_com_ressalva"` se ficou risco declarado ou lacuna aceita.
2. Todos os entregáveis de `bootstrap` com `feito: true` e o `caminho` preenchido.
3. `fase_atual = "discovery"`.
4. `fases.discovery.status = "em_andamento"`. Ela nasce `"nao_iniciada"`; sem isso o estado fica contraditório, com `fase_atual` apontando para uma fase que o próprio registro diz que não começou.
5. Atualize a fase do projeto em `~/.ai-squad/projetos.json`.
6. Regenere `estado.js`, atualize o painel e o README, e faça commit.

Só então invoque `aisquad-discovery`. Pular o passo 3 deixa o projeto travado nesta fase para sempre, e a próxima sessão retoma no lugar errado.

**Nomes dos entregáveis**: use exatamente os nomes da tabela em [`estado.md`](../ai-squad/referencias/estado.md). Nunca invente nome nem escreva sem acento: o que vai para o estado aparece no painel exatamente como foi escrito.
