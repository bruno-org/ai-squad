---
name: aisquad-discovery
description: Fase 1 do AI-SQUAD. Transforma uma ideia em produto definido, com visão lastreada, riscos derrubados e plano de construção. Use quando o AI-SQUAD entrar na fase de discovery, quando alguém tiver uma ideia de produto sem saber se se sustenta, ou quando faltar PRD, protótipo ou plano técnico em um projeto.
---

Discovery é onde a ideia vira produto de verdade ou morre antes de custar caro.

A conta que fecha esta fase: **visão lastreada por estratégia, quatro riscos derrubados, quatro Ps definidos.** Enquanto isso não estiver de pé, ninguém escreve código.

O builder traz a visão. Você traz o resto.

## 1. A visão

O builder fala. Você escuta e puxa detalhe, uma pergunta por vez, até ter clareza sobre: o que é, o que resolve, para quem, o que ele pode vir a ser.

Escreva a visão e leia de volta para o builder. O builder precisa se reconhecer ali antes de vocês seguirem.

Nesse momento, classifique a criticidade do projeto. Ver [`criticidade.md`](../ai-squad/referencias/criticidade.md). Ela vai reger o rigor de tudo daqui em diante.

**Assuma bootstrap e siga**, ver princípio 5: dinheiro do próprio bolso, sem investidor, e a meta é se pagar o quanto antes. Não pergunte isso como se fosse um formulário. Se em algum momento o builder mencionar investidor, sócio capitalista, fomento ou empresa bancando, aí você confirma e grava `projeto.financiamento` como `investido`, porque a conta muda inteira.

## 2. A estratégia

Aqui você trabalha e espera. Diga isso ao builder, e diga o que está fazendo enquanto faz.

Qualquer ideia parece uma visão. O que separa visão de ruído é lastro. Vá buscar:

- Negócios parecidos que já existiram, aqui e no mundo, e o que aconteceu com eles.
- Quem já disputa esse espaço, e como cobra.
- Regulação do setor, se houver.
- Tamanho e comportamento desse mercado.

Use o Open PM Strategy e a busca na internet. Ver [`dependencias.md`](../ai-squad/referencias/dependencias.md) e [`fontes.md`](../ai-squad/referencias/fontes.md).

Ao final, você tem uma posição. Diga com franqueza:

- **A visão se sustenta**: mostre em que se apoia e siga.
- **A visão não se sustenta**: diga por quê, com evidência concreta, e proponha um caminho diferente. O builder decide se pivota. Se o builder mantiver, isso é risco declarado, registrado, e vocês seguem. Ver [`guarda.md`](../ai-squad/referencias/guarda.md).

Salve em `01-discovery/` e registre a decisão.

## 3. Os quatro riscos

Todo risco começa em **alto**, porque no começo só existe incerteza. Ele desce quando alguma coisa concreta removeu incerteza. Nunca desce porque o tempo passou ou porque ficou animada.

A ordem importa: cada um só faz sentido depois do anterior.

1. **Negócio**: isso dá o retorno que espera?
2. **Valor**: alguém quer isso a ponto de pagar ou de usar?
3. **Usabilidade**: dá para fazer de um jeito que as pessoas consigam usar?
4. **Viabilidade técnica**: dá para construir, com segurança, e entregar do jeito planejado?

O detalhamento de cada um, o que faz o nível cair e como medir está em [`riscos.md`](riscos.md). Leia antes de atacar o primeiro.

A cada avanço, atualize o nível e o motivo em `estado.json`. O motivo é escrito para o builder ler no dashboard: "alto porque você ainda não conversou com ninguém que tenha esse problema".

## 4. Os quatro Ps

Fecham a fase, e não são pesquisa nova: reaproveitam tudo que os riscos já levantaram.

- **Produto**: o que exatamente vai existir, no que ele é diferente.
- **Preço**: quanto custa e **em que modelo** (assinatura, pagamento único, gratuito com pago em cima, faixas).
- **Praça**: onde a pessoa encontra e compra.
- **Promoção**: como fica sabendo que existe.

Em bootstrap, **Preço não é o último P, é o primeiro**. O produto precisa se pagar, então o preço não pode ser o que sobra depois de decidir todo o resto. Traga junto o **ponto de equilíbrio**: quantas vendas por mês cobrem o custo de operar. Se esse número for maior que o alcance que o builder tem hoje, isso é achado, e é melhor aparecer agora.

**O modelo de preço é decisão travada aqui.** O Delivery vai construir o pagamento em cima dele. O Go-to-Market depois pode mexer no valor e no empacotamento à vontade, mas trocar o modelo obriga a refazer o pagamento, e você avisa isso ao builder na hora em que pensar em mudar.

Hormozi e Crossing the Chasm, no Open PM Strategy, resolvem preço e praça.

## 5. Os três entregáveis finais

Tudo que veio antes (visão, estratégia, ICP, Lean Canvas, modelagem financeira, pesquisa, quatro Ps) fica registrado no estado e aparece no painel como progresso. O que **fecha a fase** são estes três, e é neles que o Delivery se apoia.

**PRD**, em `01-discovery/`: visão, estratégia e o lastro do builder, ICP, os quatro riscos com nível final e o que foi feito em cada um, os quatro Ps, e o que ficou como risco declarado. Português com acentuação correta. É o documento que amarra tudo.

**Protótipo**, em `01-discovery/prototipo/`: média ou alta fidelidade, HTML. Chame `aisquad-design`.

**Plano técnico**, em `01-discovery/`: arquitetura da solução, decisões técnicas com o porquê de cada uma, o desenho de como se conecta, o formato de distribuição e a infra correspondente, e **os cenários de teste escritos**. O Delivery recebe isso pronto e executa. Chame `codebase-design` e `domain-modeling` do Matt Pocock.

Formato de distribuição define a infra, e cada natureza puxa um caminho: site ou sistema web vai para Cloudflare Pages; produto com conta e dados puxa Supabase; aplicativo de computador vira executável; aplicativo de celular passa por loja; PWA sai pelo próprio site.

## 6. Conformidade legal e LGPD

**Obrigatório, e antes de a arquitetura fechar.** Chame `aisquad-compliance`.

Ele mapeia quais dados de pessoa o produto vai coletar, acha a base legal de cada um, pesquisa a regulação do setor em que está entrando, e diz o que a arquitetura precisa prever. Fazer isso agora é barato; descobrir depois que o produto inteiro trata dado de um jeito que não pode custa retrabalho.

O resultado entra no PRD e vira o entregável `Compliance e LGPD`. Se a regulação do setor for pesada a ponto de mudar a viabilidade do negócio, isso volta como risco e pode até derrubar a visão. Melhor saber agora.

## Quando o Discovery acaba

Duas condições, juntas:

- Os quatro riscos em **moderado ou baixo**.
- Os três entregáveis fechados.

Aí você recomenda seguir para a construção, e invoca `aisquad-delivery`.

Se o builder quiser seguir com algum risco ainda em alto: insista duas vezes, mostrando o que especificamente pode dar errado no produto. Se o builder mantiver de forma consciente, registre em `riscos_declarados`, deixe o risco no nível real, marque no PRD que aquela mitigação não foi feita, e siga.

O sistema nunca escreve que um risco foi mitigado quando ele não foi. E nunca deixa o builder sem caminho.

## Antes de virar a fase

Nesta ordem, sem pular nenhum:

1. `fases.discovery.status = "concluida"`, ou `"concluida_com_ressalva"` se ficou risco declarado ou lacuna aceita.
2. Todos os entregáveis de `discovery` com `feito: true` e o `caminho` preenchido.
3. `fase_atual = "delivery"`.
4. `fases.delivery.status = "em_andamento"`. Ela nasce `"nao_iniciada"`; sem isso o estado fica contraditório, com `fase_atual` apontando para uma fase que o próprio registro diz que não começou.
5. Atualize a fase do projeto em `~/.ai-squad/projetos.json`.
6. Regenere `estado.js`, atualize o painel e o README, e faça commit.

Só então invoque `aisquad-delivery`. Pular o passo 3 ou o passo 4 deixa o projeto travado ou contraditório, e a próxima sessão retoma no lugar errado.

**Nomes dos entregáveis**: use exatamente os nomes da tabela em [`estado.md`](../ai-squad/referencias/estado.md). Nunca invente nome nem escreva sem acento: o que vai para o estado aparece no painel exatamente como foi escrito.
