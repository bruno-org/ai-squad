# Projeto que não nasceu aqui

O AI-SQUAD pode ser plugado num projeto que já existe. Nesse caso ele não recomeça do zero: descobre onde o projeto está e entra dali.

Reconhecer trabalho que já foi feito é diferente de pular trabalho que nunca foi feito. O primeiro é obrigação sua. O segundo continua proibido.

## Descubra sozinho antes de perguntar

Leia o projeto inteiro antes de abrir a boca. O builder pode não saber responder nada disso.

- Manifestos e travas de dependência: `package.json`, `requirements.txt`, `go.mod`, `Gemfile` e equivalentes.
- Configuração de infra e publicação: `Dockerfile`, `wrangler.toml`, `vercel.json`, `netlify.toml`, workflows do GitHub.
- Git: existe repositório? Tem remoto? É privado? Quantos commits, e desde quando?
- Documentação: README, pasta de documentos, qualquer `.md` que descreva o que o produto é.
- Está no ar? Procure URL em configuração, README e histórico.
- Tem teste? Tem monitoramento? Tem analytics?

Só o que sobrar sem resposta vira pergunta, uma de cada vez, em linguagem simples. "Esse produto já está publicado em algum lugar que as pessoas conseguem acessar?" funciona; "qual a stack de deploy?" não.

## Duas perguntas diferentes

Não basta descobrir em que estágio o produto está. Descubra também **quais entregáveis existem**, porque as duas coisas divergem com frequência.

**Estágio**: o produto tem código? Está publicado? Tem gente usando?

**Entregáveis**: existe documento que diz o que o produto é e para quem? Existe análise dos riscos? Existe protótipo? Existe plano técnico?

Um produto no ar, construído no impulso, sem nenhum documento, está no estágio de Ciclo de Vida e com todos os entregáveis do Discovery em falta. Isso é comum e é exatamente o caso que o cruzamento das duas perguntas pega.

## Onde entrar

Pelo **estágio**, não pelos entregáveis:

| O que você encontrou | Fase de entrada |
|----------------------|-----------------|
| Só ideia, sem código | Discovery |
| Código em construção, nada publicado | Delivery |
| Publicado, mas sem teste ou sem auditoria | Qualidade e Segurança |
| Publicado e testado, sem plano de lançamento | Go-to-Market |
| No ar, com gente usando | Ciclo de Vida |

## O que fazer com o que falta

Cada entregável ausente vira um item em `lacunas`, no estado, dizendo qual é, de que fase, e o que ele impede.

As lacunas aparecem no dashboard. Elas **não** bloqueiam a entrada.

Quando uma lacuna atrapalhar o trabalho da fase atual, aí sim você para e propõe fechar o mínimo necessário, explicando por quê em termos práticos. Produto no ar sem saber para quem ele é não tem como receber recomendação decente de crescimento, e você diz isso, em vez de fingir que tem base para opinar.

Fechar lacuna é sempre versão enxuta. O objetivo é ter chão para decidir, não refazer um Discovery inteiro para trás.

## Três regras que mudam neste modo

**Pasta.** Os artefatos ficam dentro da pasta do projeto que já existe, em `.ai-squad/` e nas subpastas de documentação. Nada de pasta nova na área de trabalho.

**Ferramenta.** A preferência por gratuito e aberto vale para o que você **acrescentar**. Não proponha migrar a infra atual porque você preferia outra. Se a atual for insegura ou estiver custando caro à toa, aí é assunto da guarda de tiro no pé, não de gosto.

**Monitoramento.** Se não houver Sentry nem PostHog, proponha instalar, explicando que sem isso o Ciclo de Vida não tem o que analisar. O builder decide, porque é mudança no produto e evolução é aprovada.

## Registre a entrada

Grave em `estado.json` o modo `existente`, a fase detectada, os entregáveis encontrados e as lacunas. E abra `decisoes.md` com uma entrada explicando por que o sistema entrou naquela fase. Daqui a três meses, ninguém vai lembrar.
