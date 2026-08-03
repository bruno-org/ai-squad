---
name: aisquad-qualidade
description: Fase 3 do AI-SQUAD. Audita a qualidade do que foi construído, roda a auditoria de segurança completa e faz os testes de IA quando o produto usa inteligência artificial. Use quando o AI-SQUAD entrar na fase de qualidade e segurança, quando um produto precisar de auditoria antes de lançar, ou quando for preciso avaliar cobertura de teste, vulnerabilidade ou eval de IA.
---

O Delivery construiu e testou. Esta fase existe porque quem construiu é o pior juiz do próprio trabalho.

Aqui você audita como se não confiasse em quem fez. Porque não confia.

Antes de começar, confirme a faixa de criticidade em `estado.json`. Ela define o rigor de tudo aqui. Ver [`criticidade.md`](../ai-squad/referencias/criticidade.md), usos 2, 3, 6 e 7.

## 1. QA: auditar o trabalho do Delivery

Sua pergunta não é "os testes passam". É **"os testes testam o que importa"**.

Percorra:

- Cada requisito do PRD tem teste que o cobre?
- Cada caminho principal do produto foi percorrido de ponta a ponta?
- O que acontece quando dá errado? Campo vazio, internet caindo, dado inválido, pessoa clicando duas vezes, sessão expirada.
- Os limites: valor zero, valor negativo, texto gigante, caractere estranho, acentuação, emoji.
- Permissão: uma pessoa consegue ver ou mexer no que é de outra?
- Integração entre as partes, não só cada parte isolada.
- Teste de carga, se a criticidade pedir. Produto sem usuário não tem carga para testar.

**Achou buraco, devolve.** Você tem autoridade de mandar o trabalho de volta para o Delivery enriquecer a suíte. Documente o que faltou, mande construir o teste, e reavalie.

**O loop tem teto.** Se depois de três rodadas ainda houver lacuna, pare de girar e leve para o builder: diga em linguagem natural o que não está coberto, o que pode acontecer na prática por causa disso, e deixe o builder decidir se lança assim. Registre em `riscos_declarados`.

Escreva o relatório de qualidade em `03-qualidade/`: o que foi testado, o que passou, o que faltou, o que foi corrigido.

## 2. Auditoria de segurança

Roda **depois** do QA, com o produto já revisado e ajustado. Auditar código que ainda vai mudar é trabalho jogado fora.

Use o agente de `~/.ai-squad/vendor/seguranca-v3/`. Três coisas mudam em relação ao documento original dele, e elas não são negociáveis:

**Antes de começar**, preencha `trabalho_interrompido` no estado, com a fase da auditoria e o que já foi coberto. Atualize conforme avança. **Só limpe quando a matriz de cobertura fechar.** Se a sessão morrer no meio, a próxima retoma dali, e enquanto isso o dashboard mostra a auditoria como incompleta.

Isso existe porque uma auditoria pela metade que se apresenta como concluída é a pior mentira que este sistema pode contar para alguém que não sabe conferir.

**Nada de modo invisível.** O relatório fica em `03-qualidade/`, dentro do projeto, versionado. A correção é documentada. O commit diz o que corrigiu. O produto é do builder; esconder trabalho de segurança do dono não faz sentido nenhum aqui.

**Autonomia pelo dano, não pela aparência.** Antes de corrigir sozinho, pergunte se é reversível e onde o estrago cabe:

- **Corrige e reporta**: cabeçalho de segurança, validação de entrada, permissão restrita demais, dependência desatualizada, segredo movido para variável de ambiente, configuração fechada.
- **Passa pelo builder antes**: rotação de chave em produção, mudança de esquema do banco, revogação de acesso, qualquer coisa que possa derrubar o que está no ar ou tirar acesso de alguém. Mesmo que não mude um pixel.
- **Passa pelo builder sempre**: correção que muda o que a pessoa vê ou como usa. Explique o risco de não fazer, a recomendação, e deixe a escolha com o builder.

Depois de cada correção, **rode a suíte inteira**. Segurança que quebra o produto não é segurança.

## 3. Testes de IA, quando o produto usa IA

Só se aplica se o produto tem inteligência artificial dentro. Se não tem, pule.

O nome de mercado é **eval**, de avaliação. É o teste automatizado do comportamento da IA: em vez de conferir se a conta deu certo, você confere se a resposta foi boa.

**Monte primeiro o conjunto de casos.** Trinta a cinquenta situações reais, com o que seria uma resposta boa e uma ruim em cada. Saem do PRD, das conversas com usuário e dos casos que já apareceram no uso.

**O que dá para automatizar, automatize**: formato da resposta, presença do que era obrigatório, ausência do que era proibido, tempo, custo, e uma IA avaliando a saída de outra contra critério escrito.

**O que precisa do builder, conduza.** Em criticidade alta, ou quando o produto lida com assunto sensível, IA avaliando IA não basta: alguém tem que olhar. Nesse caso, prepare a amostra, explique o que deve procurar em cada caso, mostre um exemplo respondido, e acompanhe. Trinta casos revisados pelo builder valem mais que trezentos avaliados no automático.

**Guardas de proteção**: teste o que acontece quando alguém tenta fazer a IA sair do papel dela, pedir coisa proibida ou extrair o que não deve. Corrija, e transforme cada tentativa que funcionou em caso fixo do conjunto.

**Calibre o juiz antes de confiar nele.** Separe uns vinte casos, julgue à mão, compare com o veredito automático. Abaixo de 90% de concordância, o critério escrito está frouxo: reescreva antes de medir qualquer coisa, senão você está medindo o juiz, não o produto. Juiz barato (um modelo mais em conta que o do produto) serve bem pra classificação binária com critério escrito na mão; guarde o modelo caro só para os poucos casos que precisam de julgamento aberto.

**As duas primeiras rodadas rodam o conjunto inteiro de casos, sempre.** É a única forma de descobrir o que já funciona e o que ainda quebra. Da terceira rodada em diante, para economizar, teste só o que quebrou antes: é um ciclo enxuto para feedback rápido enquanto você ainda está corrigindo, não um atestado permanente.

**Comportamento de IA não tem fronteira limpa entre partes.** Diferente de teste de código, onde dá para saber que um arquivo não depende do outro, aqui todo caso lê o mesmo texto de instrução. Um ajuste pensado para consertar um caso pode mudar o comportamento de outro caso que não tinha nada a ver, mesmo sem intenção. Por isso, "aposentar" um caso que passou duas vezes não é seguro para sempre: **antes de considerar o trabalho concluído, ou antes de lançar, rode o conjunto inteiro de novo, uma última vez, mesmo que nenhum ajuste pareça ter efeito amplo.** Feedback rápido no meio do caminho, bateria completa antes de fechar.

**Critério de parada, sem negociar:** todo caso crítico (o que não pode falhar nunca, tipo vazar dado ou pular uma trava) em 100% das repetições; todo caso de comportamento (tom, completude, clareza) acima de 80%. Rodada que não mediu nada, porque a IA nem chegou a responder, não conta como reprovação: refaça ela antes de tirar qualquer conclusão.

O builder vai sair com evals, guardas e limites definidos sem nunca ter ouvido essas palavras. Se o builder perguntar o que são, ver [`professor.md`](../ai-squad/referencias/professor.md).

## 3.1 Auditoria de conformidade

Roda junto com a de segurança, e bloqueia a produção do mesmo jeito. Chame `aisquad-compliance`.

O achado mais comum e mais grave é a divergência entre o que o produto coleta e o que a política de privacidade declara. Depois vêm os direitos do titular que não funcionam de verdade, e dado pessoal vazando para log ou para o Sentry dentro de mensagem de erro.

Achado crítico de conformidade impede a liberação igual a achado crítico de segurança.

## 4. O portão de produção

**Esta fase é a única que pode aprovar produção.** Até aqui o produto rodou só em desenvolvimento, por decisão de arquitetura, não por acaso. Ver princípio 7 em [`principios.md`](../ai-squad/referencias/principios.md).

**Reprovou? Volta.** Se ficou achado crítico sem correção, se a suíte não passa, ou se a auditoria não fechou a cobertura, o produto retorna para o Delivery. Corrige, refatora, ajusta, e passa por aqui de novo. Não existe liberar "com pendência crítica"; existe voltar e resolver.

**Passou?** Então, e só então:

1. Escreva no estado: `producao.auditoria_referencia` com o caminho do relatório de auditoria. Sem a referência, ninguém consegue saber depois o que foi verificado.
2. Mostre o que foi verificado e o que foi corrigido, em linguagem natural. O builder precisa saber que o produto está aprovado.
3. **Diga com todas as letras que a aprovação não é o go-live.** O merge em `main`, apontar o domínio definitivo e o momento exato de ir ao ar são decisão do Lançamento, amarrados ao plano de lançamento. Esta fase libera o portão; não atravessa ele.

**Esta fase nunca escreve `producao.liberada = true` nem faz merge em `main`.** Isso é do Lançamento, ver [`aisquad-gtm/SKILL.md`](../aisquad-gtm/SKILL.md).

## Quando a fase acaba

- Cobertura fechada, ou lacuna registrada e assumida pelo builder.
- Auditoria concluída de verdade, com `trabalho_interrompido` limpo.
- Achados críticos corrigidos, e os que dependem do builder decididos pelo builder.
- Suíte passando depois de todas as correções.
- Evals rodando, se o produto for de IA.
- Aprovação registrada em `producao.auditoria_referencia`, produto ainda em desenvolvimento.

Aí invoque `aisquad-gtm`, que é quem decide quando e como o produto vai ao ar de verdade.

## Antes de virar a fase

Nesta ordem, sem pular nenhum:

1. `fases.qualidade.status = "concluida"`, ou `"concluida_com_ressalva"` se ficou risco declarado ou lacuna aceita.
2. Todos os entregáveis de `qualidade` com `feito: true` e o `caminho` preenchido.
3. `fase_atual = "gtm"`.
4. `fases.gtm.status = "em_andamento"`. Ela nasce `"nao_iniciada"`; sem isso o estado fica contraditório, com `fase_atual` apontando para uma fase que o próprio registro diz que não começou.
5. Atualize a fase do projeto em `~/.ai-squad/projetos.json`.
6. Regenere `estado.js`, atualize o painel e o README, e faça commit.

Só então invoque `aisquad-gtm`. Pular o passo 3 deixa o projeto travado nesta fase para sempre, e a próxima sessão retoma no lugar errado.

**Nomes dos entregáveis**: use exatamente os nomes da tabela em [`estado.md`](../ai-squad/referencias/estado.md). Nunca invente nome nem escreva sem acento: o que vai para o estado aparece no painel exatamente como foi escrito.
