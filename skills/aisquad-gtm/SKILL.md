---
name: aisquad-gtm
description: Fase 4 do AI-SQUAD. Monta o plano de lançamento completo e produz o material para executá-lo. Use quando o AI-SQUAD entrar na fase de go-to-market, quando um produto pronto precisar de estratégia de lançamento, ou quando for preciso definir canal, preço final, campanha ou produzir conteúdo de divulgação.
---

O produto está pronto e aprovado pela Qualidade, mas ainda roda só em desenvolvimento. **Esta fase é quem decide quando e como ele vai ao ar de verdade**, amarrado ao plano de lançamento, não automaticamente no instante em que a auditoria fechou.

Boa parte do insumo já foi levantada no Discovery. Esta fase calibra com a realidade do produto que existe, e não com o que foi imaginado meses atrás.

As skills de engenharia do Matt Pocock não servem aqui. O Open PM Strategy é a dependência desta fase.

## 1. Reconcilie a fonte da verdade

Primeira coisa, antes de qualquer estratégia. O produto mudou no caminho; o plano tem que falar do produto que existe.

Percorra o Discovery e o Delivery procurando divergência:

- O que o produto faz hoje bate com o que o PRD descreve?
- O ICP continua o mesmo depois do que apareceu nas conversas e no protótipo?
- O preço e o modelo continuam válidos?
- Alguma coisa prometida ficou de fora? Alguma coisa não prevista entrou?

**Atualize os documentos anteriores** para refletir a realidade. O PRD final descreve o produto real.

**Mas não apague o histórico.** O porquê de cada decisão fica em `decisoes.md`, intocado. Documento vivo se atualiza; registro de decisão não se reescreve. É isso que impede o PRD final de mentir sobre como o projeto realmente aconteceu.

Se algo mudou de forma relevante, conte o que mudou e o que isso significa para o lançamento.

## 2. Complete o que falta

Você não recomeça pesquisa. Reaproveita o que o Discovery levantou e só produz o que falta.

Refaça apenas o que envelheceu: se passaram meses desde o estudo de mercado, os preços dos concorrentes mudaram e o cenário competitivo também. Dado velho leva a plano errado.

Feche os quatro Ps com o produto real na mão:

- **Preço**: o número final e o empacotamento. O modelo veio travado do Discovery; aqui você ajusta valor e pacote. Se o builder quiser mudar o modelo, avise que isso mexe no pagamento já construído.
- **Praça**: onde a pessoa encontra e compra.
- **Promoção**: por onde fica sabendo.
- **Produto**: como ele é apresentado e posicionado.

Use as bases do Open PM Strategy: Hormozi para oferta, preço e garantia; Crossing the Chasm para posicionamento, público e canal; Growth Systems para aquisição e retenção. Descarte a premissa de financiamento delas, ver [`dependencias.md`](../ai-squad/referencias/dependencias.md).

**Lançamento de bootstrap não é lançamento de startup investida**, ver princípio 5. O que muda:

- **Canal que custa trabalho vence canal que custa dinheiro.** Conteúdo, comunidade, parceria, indicação e busca orgânica primeiro. Anúncio pago só quando já existe venda acontecendo e dá para medir se cada real volta.
- **A primeira meta é a primeira venda**, não o primeiro milhar de usuários. Depois é repetir a venda de forma previsível.
- **Sem queima planejada.** Se o plano só fecha gastando um dinheiro que o builder não tem, o plano está errado, não o orçamento.
- Nada de deck, valuation ou métrica que só serve para impressionar investidor, a menos que o builder peça.

## 3. O plano de lançamento

Escreva em `04-go-to-market/`, completo e extensivo, e ao mesmo tempo legível por quem nunca lançou nada.

Cada frente de lançamento vira uma sequência de passos concretos, com o que fazer, em que ordem e o que se espera de cada um. Não escreva "definir estratégia de conteúdo". Escreva "publicar três posts por semana, nesta ordem de assunto, nestes dias, com este objetivo".

O plano inclui:

- Posicionamento e a mensagem central.
- Público de cada fase do lançamento.
- Canais escolhidos, e por que esses e não outros.
- Cronograma, com o que acontece antes, no dia e depois.
- O que medir para saber se está funcionando, com os números vindo do PostHog que já está instalado.
- O que fazer se não funcionar.

Explique cada decisão. O builder precisa entender o plano para conseguir executá-lo, e vai executar sozinho depois que você sair da frente.

## 4. Produza o material

O plano não para no papel. O que ele pedir de material, você produz junto, usando todo o contexto do produto que você acumulou desde o Discovery.

Conteúdo de rede social, texto de página de venda, e-mails de lançamento, anúncios, roteiro de vídeo, imagem, apresentação: tudo em `04-go-to-market/material/`.

Para e-mail, use os modelos de inboxpedia. Para peça visual, chame `aisquad-design` e mantenha a identidade do produto. Ver [`fontes.md`](../ai-squad/referencias/fontes.md).

**Idioma do material segue o mercado do produto**, não o idioma do sistema. Produto que mira fora do Brasil tem material em inglês. Ver princípio 2 em [`principios.md`](../ai-squad/referencias/principios.md).

## 5. O go-live

O produto só vai ao ar quando o cronograma do plano de lançamento chegar nesse ponto, nunca antes. Pode ser no mesmo dia em que a Qualidade aprovou, pode ser semanas depois, se o plano previr um período de pré-lançamento (lista de espera, teaser, aquecimento de audiência).

Quando chegar a hora, nesta ordem:

1. **Peça o aval para o go-live.** É o momento mais importante do projeto inteiro; não trate como rotina. Explique o que vai acontecer, que o produto passa a ficar acessível para qualquer pessoa, e o que fazer se algo der errado.
2. Com o aval, faça o merge em `main`, aponte o domínio definitivo, e confirme que o endereço abre com cadeado.
3. Verifique com os próprios olhos: caminho principal funcionando em produção, Sentry recebendo erro, PostHog recebendo evento.
4. Escreva no estado: `producao.liberada = true`, `producao.liberada_em` com a data em DD/MM/AAAA, `infra.url_producao` com o endereço que você acabou de conferir, e o entregável `Produto em produção` com `feito: true`. Ele é desta fase, não da Qualidade: quem aprovou não publicou.

Depois deste momento, manutenção sobe sozinha pela esteira e evolução continua passando pelo builder.

## Quando a fase acaba

- Documentos anteriores reconciliados com o produto real.
- Quatro Ps fechados com dado atual.
- Plano de lançamento escrito, com cronograma e passo a passo.
- Material operacional produzido e pronto para usar.
- `producao.liberada = true` e o produto no ar, com o aval, no momento que o próprio cronograma do lançamento previu.

Aí invoque `aisquad-lifecycle`, que é onde o sistema passa a viver junto com o produto.

## Antes de virar a fase

Nesta ordem, sem pular nenhum:

1. `fases.gtm.status = "concluida"`, ou `"concluida_com_ressalva"` se ficou risco declarado ou lacuna aceita.
2. Todos os entregáveis de `gtm` com `feito: true` e o `caminho` preenchido.
3. `fase_atual = "lifecycle"`.
4. `fases.lifecycle.status = "em_andamento"`. Ela nasce `"nao_iniciada"`; sem isso o estado fica contraditório, com `fase_atual` apontando para uma fase que o próprio registro diz que não começou.
5. Atualize a fase do projeto em `~/.ai-squad/projetos.json`.
6. Regenere `estado.js`, atualize o painel e o README, e faça commit.

Só então invoque `aisquad-lifecycle`. Pular o passo 3 deixa o projeto travado nesta fase para sempre, e a próxima sessão retoma no lugar errado.

**Nomes dos entregáveis**: use exatamente os nomes da tabela em [`estado.md`](../ai-squad/referencias/estado.md). Nunca invente nome nem escreva sem acento: o que vai para o estado aparece no painel exatamente como foi escrito.
