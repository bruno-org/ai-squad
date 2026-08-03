# Os quatro riscos, em detalhe

Framework de Marty Cagan. Cada risco é uma pergunta que, sem resposta, quebra o produto de um jeito diferente.

Todo risco nasce **alto**. Desce quando incerteza foi removida por trabalho concreto, nunca por otimismo.

A escala e o que significa:

- **Alto**: ninguém sabe. É palpite.
- **Moderado**: há indício, mas ainda pode desmentir.
- **Baixo**: há evidência suficiente para apostar.

---

## 1. Risco de negócio

**A pergunta**: esse produto entrega ao negócio o retorno que o negócio espera dele?

Antes de qualquer conta, descubra **o que espera**, porque o critério muda inteiro:

- **Produto para vender**: sucesso é receita e lucro.
- **Produto interno**: sucesso é eficiência, tempo economizado, custo cortado.

Ideia boa que só opera no vermelho não vira produto. Isso é o que este risco pega.

**O padrão é bootstrap: capital próprio, sem investidor, lucrativo o quanto antes.** Ver princípio 5 em [`principios.md`](../ai-squad/referencias/principios.md). Na prática, aqui, isso muda a conta:

- A pergunta não é quanto tempo o dinheiro dura até a próxima rodada. É **em quanto tempo isso se paga**, e quanto precisa vender por mês para cobrir o próprio custo.
- **O ponto de equilíbrio é entregável, não curiosidade.** Quantas vendas por mês cobrem a operação. Se esse número for grande demais para o alcance que o builder tem hoje, o problema apareceu antes de custar caro.
- Crescer devagar e no azul vence crescer rápido no vermelho. Estratégia que só fecha com muito dinheiro na frente não serve, mesmo quando é a mais citada no mercado.
- Custo fixo é inimigo. Prefira o que escala com a receita e o que dá para desligar.

Só troque essa lente se o builder disser que a empreitada tem outro viés, como investimento anjo, fomento, sócio capitalista ou operação subsidiada. Aí a conta passa a ser outra, e você registra isso no estado.

**A conta tem dois lados, e um lado sozinho não responde nada.** Saber que o concorrente cobra 49 reais por mês diz quanto dá para cobrar. Não diz se sobra dinheiro no fim. Risco de negócio é a diferença entre entrar e sair, então os dois lados são obrigatórios.

**Lado que entra**

- O que os concorrentes cobram, e em que modelo.
- Quantas pessoas plausivelmente pagariam, e com que frequência.
- Em produto interno não há receita: o que entra é economia. Quanto tempo ou quanto custo aquilo corta, em dinheiro.

**Lado que sai**

- Infra e ferramenta, mês a mês, considerando o que acontece quando o plano gratuito estoura.
- Taxa de meio de pagamento, que come um pedaço de cada venda.
- Custo de trazer cliente. Produto que precisa de anúncio para vender tem esse custo em cada venda, e é ele que quebra a maioria das contas que pareciam boas.
- Suporte e manutenção, inclusive o tempo do builder, que não é de graça só porque não sai do bolso.

**Junte os dois**

- Projeção com as premissas escritas e visíveis. Premissa escondida transforma planilha em ficção.
- Estudar negócios parecidos que já rodaram, aqui ou fora, e o que aconteceu com eles. Muita ideia boa já morreu com o custo que ninguém tinha somado.

### Lean Canvas

Vital, e insuficiente sozinho. Uma página com os nove campos que compõem um modelo de negócio, que força a olhar o negócio inteiro em vez de só a parte que empolga.

O que ele faz: **mapeia** o modelo e expõe incoerência entre as partes.

O que ele não faz: **dimensionar**. O canvas diz que existe receita de assinatura e custo de infra. Ele não diz quantas assinaturas cobrem a infra, nem em quantos meses, nem o que acontece se a conversão for metade do esperado. Isso é a modelagem financeira, e é obrigatória do mesmo jeito.

Os dois se completam: o canvas dá a estrutura, a modelagem dá os números que provam ou derrubam essa estrutura. Nenhum dos dois fecha este risco sozinho.

Monte o canvas com o builder, campo a campo:

| Campo | A pergunta, do jeito que se faz para o builder |
|-------|------------------------------------------|
| Problema | quais são os três problemas principais que você resolve? |
| Segmento | de quem exatamente é esse problema? |
| Proposta de valor | por que alguém escolheria isso e não o que já usa? |
| Solução | qual é a menor coisa que resolve cada um dos três problemas? |
| Canais | por onde essas pessoas chegam até você? |
| Receita | como entra dinheiro, e quanto? |
| Custos | o que sai, todo mês e por venda? |
| Métricas-chave | quais números dizem se está dando certo? |
| Vantagem injusta | o que um concorrente com dinheiro não copiaria em um mês? |

**Você não entrega o canvas em branco para o builder preencher.** O builder não saberia por onde começar, e a maior parte das respostas nem é do builder: está em pesquisa, e a pesquisa é trabalho seu.

Para cada campo, faça o levantamento, traga a proposta de preenchimento fundamentada, e confirme o que for decisão de negócio. Busque preço e posicionamento de concorrente, custo real das ferramentas, tamanho e comportamento do mercado, referências de negócios equivalentes. Use as bases do Open PM Strategy: Lean Startup e Hormozi respondem receita, custo e proposta de valor; Mom Test responde problema e segmento; Crossing the Chasm responde canal e vantagem.

Os campos conversam entre si, e é aí que o canvas mostra o serviço dele: se a receita não cobre o custo, se o canal não alcança o segmento, se a vantagem injusta não existe, o furo aparece na página, antes de aparecer no extrato bancário.

Salve em `01-discovery/` e revisite sempre que algum campo mudar.

**Chega em baixo quando** o Lean Canvas está preenchido e coerente, a modelagem financeira existe com os dois lados e as premissas escritas, e a diferença entre eles atende o que espera do produto.

**Fica em moderado quando** o canvas está de pé mas os números ainda não foram dimensionados, ou o contrário.

**Continua alto se** só um dos lados foi levantado, ou se o único argumento for "acho que as pessoas vão pagar".

Ferramentas: Hormozi para modelo de receita e preço; Crossing the Chasm para tamanho e fase de mercado; busca na internet para preço de concorrente.

---

## 2. Risco de valor

**A pergunta**: alguém quer isso a ponto de pagar, ou pelo menos de usar?

É onde mais produto morre. A conta fecha na planilha, a empresa gosta da ideia, e nenhuma pessoa real se importa.

**Primeiro, o ICP.** Quem exatamente é essa pessoa. Não "pequenos empresários", e sim "dono de salão de beleza com dois a cinco funcionários, que hoje agenda por WhatsApp e perde horário". Quanto mais fatiado, mais útil. Segmento vago produz produto vago.

**Depois, a dor.** O builder é real ou cosmética? Dor real a pessoa já tenta resolver de algum jeito hoje, mesmo que de um jeito ruim. Dor cosmética a pessoa acha chata e nunca gastou um centavo com.

O **teste da mãe** é o nome do método: sua mãe diria que sua ideia é ótima de qualquer jeito, porque te ama. Então nunca pergunte se a ideia é boa. Pergunte sobre a vida da pessoa: como faz isso hoje, quando foi a última vez que deu problema, o que já tentou, quanto isso já custou. Fato do passado vale; opinião sobre o futuro não vale nada.

**O que vale é o sinal de comportamento, não o método.**

Entrevista é um caminho, e não é o único. O que derruba este risco é evidência de que **as pessoas já se comportam** como quem tem essa dor. De onde vem essa evidência importa menos do que a força do builder.

**Evidência de primeira mão**, levantada agora, para este produto:

- **Conversa direta** com gente do ICP, no formato do teste da mãe.
- **Manifestação orgânica**: gente falando espontaneamente da dor em rede social, fórum, comunidade, grupo. Volume e intensidade dessa conversa são sinal forte, principalmente quando ninguém foi provocado a falar.
- **Gambiarra existente**: as pessoas já resolvem isso hoje com planilha, grupo de WhatsApp, caderno, três ferramentas emendadas. Quem monta gambiarra tem dor de verdade, porque gambiarra dá trabalho.
- **Avaliação e reclamação de concorrente**: dor documentada por gente real, de graça, e sem ninguém puxando resposta.
- **Dinheiro já saindo**: gente pagando por solução ruim, ou por serviço manual que faz aquilo.
- **Busca**: volume de gente procurando por aquilo.
- **Oferta concreta testada**: página, lista de espera, pré-venda, e quantos se mexeram.

**Evidência de segunda mão**, que já existe e alguém pagou caro para levantar. Ignorar isso é desperdício, e muitas vezes cobrem uma amostra que o builder jamais alcançaria por conta própria:

- **Pesquisa de indústria e relatório setorial**: consultoria, instituto de pesquisa, associação do setor. Costumam trazer amostra grande e metodologia declarada.
- **Estudo de tendência e de comportamento de consumo**, que mostra para onde o hábito das pessoas está indo.
- **Pesquisa acadêmica**, quando o tema tiver.
- **Dado público**: censo, órgão do governo, entidade de classe, dado aberto do setor.
- **Estudo de caso e post-mortem** de quem já tentou algo parecido, aqui ou fora.

Ao usar evidência de terceiro, sempre verifique três coisas: **quem pagou** pela pesquisa, **quando** o builder foi feita, e **quem foi ouvido**. Relatório patrocinado por quem vende a solução costuma achar que todo mundo precisa da solução. Dado de cinco anos atrás pode descrever um mundo que não existe mais. E amostra de outro país, ou de outro porte de empresa, pode não ter nada a ver com o público do builder.

## A força da evidência não é igual

Todas contam, e não pesam o mesmo. Do mais forte para o mais fraco:

1. **Alguém já paga** por isso hoje, mesmo que mal resolvido.
2. **Alguém se dá trabalho**: monta gambiarra, reclama sem ninguém perguntar, procura ativamente.
3. **Alguém contou o que fez**, em conversa no formato do teste da mãe, falando de fatos do passado.
4. **Pesquisa de terceiro** com metodologia clara, amostra do mesmo público, e sem conflito de interesse.
5. **Tendência e dado agregado**, que mostra o movimento do mercado sem falar do público específico do builder.

Comportamento vale mais que declaração, e declaração vale mais que agregado. Quanto mais alto na lista e mais fontes independentes apontando o mesmo, mais o risco desce.

O que **não** conta, venha de onde vier: elogio, opinião sobre o futuro, "eu usaria isso", "achei legal". Isso é ruído, e ruído com cara de validação é pior que nenhuma informação.

**Quem levanta é você, menos o que exige um corpo humano.**

Vasculhar Reddit, X, fórum, comunidade, avaliação de loja de aplicativo, reclamação de concorrente, volume de busca, relatório setorial, estudo de tendência, dado público: **isso é tudo trabalho seu.** Você busca, lê, cruza, conta quantas pessoas falam a mesma coisa, checa a procedência do que veio de terceiro, separa sinal de barulho e traz o resultado consolidado. No máximo pergunte onde esse público costuma se reunir, ou peça um termo que só quem é do ramo conhece. Nunca mande o builder ir procurar.

O único levantamento que depende do builder é o que exige uma pessoa falando com outra: entrevista e teste de usabilidade. Aí você prepara tudo, monta o roteiro, encontra quem abordar, escreve a mensagem, e só faz a parte que é insubstituível.

**Chega em baixo quando** existe evidência de comportamento real, de qualquer uma dessas fontes, mostrando que a dor existe e que as pessoas já se mexem por causa do builder.

**Continua alto se** nada foi levantado, ou se a única base for o que imagina que as pessoas querem.

**Qual caminho escolher** depende do produto. Dor que as pessoas expõem publicamente se lê nas redes. Dor de nicho fechado, de empresa, ou constrangedora, quase nunca aparece em público e exige conversa. Escolha o caminho pela natureza da dor, não por hábito.

Ferramentas: Mom Test para roteiro, segmentação e leitura de sinal; Lean Startup para desenhar o teste.

---

## 3. Risco de usabilidade

**A pergunta**: dá para construir de um jeito que as pessoas consigam usar sozinhas?

Ideia certa com execução confusa morre igual. A pessoa abre, não entende, fecha, não volta.

Este risco cai em dois degraus, e o primeiro é obrigação da squad.

### Degrau 1: a squad audita o protótipo

Assim que o protótipo estiver de pé, `aisquad-design` faz a auditoria. Sozinho, este degrau já derruba boa parte do risco, porque a maioria dos problemas de usabilidade é estrutural e aparece sem precisar de usuário nenhum.

Três eixos, todos obrigatórios:

**Responsividade.** Tem que funcionar inteiro, não "mais ou menos". Percorra as larguras de celular, tablet e computador. Nada de conteúdo cortado, texto espremido, botão fora da tela ou rolagem lateral. A maior parte do tráfego chega de celular, inclusive em produto pensado para computador.

**Contraste.** Texto normal precisa de pelo menos 4,5 para 1 contra o fundo, e texto grande, pelo menos 3 para 1. Vale para estado desabilitado, texto sobre imagem e mensagem de erro, que são onde isso costuma quebrar. Alvo de toque com no mínimo 44 por 44 pontos. Foco visível na navegação por teclado.

**As dez heurísticas de Nielsen.** A lista traduzida está em [`aisquad-design`](../aisquad-design/SKILL.md). Percorra uma a uma, no protótipo, e registre cada quebra com o que acontece com a pessoa por causa do builder.

Corrija tudo que aparecer e refaça a auditoria. Um protótipo que passa nos três eixos leva o risco de alto para moderado.

### Degrau 2: gente de verdade usando

O degrau 1 pega o que está estruturalmente errado. O degrau 2 pega o que estava óbvio só para quem construiu, e não tem substituto para isso.

Cinco pessoas do ICP, tentando usar sem ninguém explicar nada.

**Como conduzir, e você estrutura isso para o builder do começo ao fim**: escolha as três tarefas principais, escreva o roteiro do que pedir, ajude a encontrar as pessoas, prepare como convidar. Na hora, a regra é uma só, e é a mais difícil: ficar calado e deixar a pessoa se virar. Anote onde travou, não o que a pessoa disse que achou. Opinião engana; travamento não.

Depois, consolide os achados com o builder, transforme cada travamento em ajuste, e refaça.

**Chega em baixo quando** o protótipo passou nos três eixos da auditoria e pessoas do ICP completaram as tarefas principais sem socorro.

**Fica em moderado quando** a auditoria passou mas ninguém de fora testou ainda.

**Continua alto se** só o builder e você olharam. Quem construiu sempre acha claro.

Ferramentas: `aisquad-design` para o protótipo e a revisão; `prototype` do Matt Pocock quando a dúvida for de lógica e não de tela.

---

## 4. Risco de viabilidade técnica

**A pergunta**: dá para construir, com segurança, e entregar do jeito que foi planejado?

Vem por último de propósito: só faz sentido resolver como construir depois de saber o que vale a pena construir.

**O que derruba o nível**

- Desenhar a arquitetura da solução inteira, com as decisões técnicas e o porquê de cada uma.
- Definir o formato de distribuição e a infra que ele exige.
- Verificar cada integração externa: existe, é acessível, cabe no plano gratuito, tem limite que atrapalha?
- Escrever os cenários de teste. Se você não consegue descrever como testar, você ainda não entendeu o que vai construir.

### Prova de conceito

É a ferramenta mais forte deste risco, e é do Discovery, não do Delivery. Toda incerteza técnica considerável vira uma prova de conceito **aqui**, antes de existir plano fechado, porque é aqui que descobrir "não dá" ainda é barato.

Faça sempre que houver:

- Uma parte do produto sobre a qual ninguém sabe dizer se dá para fazer.
- Uma escolha entre dois caminhos onde a diferença só aparece tentando.
- Integração com serviço de terceiro que você nunca viu funcionar de verdade nesse formato.
- Uma exigência de desempenho, volume ou tempo de resposta que pode não se sustentar.

Uma prova de conceito boa tem três marcas: **responde uma pergunta só**, é o menor código possível que responde, e **é jogada fora depois**. Código de prova de conceito nunca vira base do produto: ele foi escrito para descobrir algo, não para durar.

Registre a resposta em `decisoes.md` e mate o código. A resposta é o que tem valor.

**Chega em baixo quando** existe arquitetura desenhada, caminho de distribuição definido, integrações verificadas, cenários escritos, e nenhuma dúvida técnica aberta que possa mudar o rumo.

**Continua alto se** existe uma parte do produto sobre a qual ninguém sabe dizer se dá para fazer.

Ferramentas: `codebase-design` e `domain-modeling` do Matt Pocock; `research` para checar fato técnico em fonte confiável; `prototype` para prova de conceito.
