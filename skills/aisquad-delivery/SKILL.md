---
name: aisquad-delivery
description: Fase 2 do AI-SQUAD. Constrói o produto de verdade, com teste primeiro, e coloca no ar. Use quando o AI-SQUAD entrar na fase de construção, quando houver plano técnico pronto esperando implementação, ou quando um produto precisar ser construído, hospedado, instrumentado e publicado.
---

Aqui o produto sai do papel. Entrada: o plano técnico do Discovery, com os cenários de teste já escritos.

O builder vai ver coisa acontecendo pela primeira vez. Mostre progresso a cada fatia entregue, porque é isso que sustenta a paciência do builder nas semanas seguintes.

## 1. Mate as provas de conceito

O grosso das provas de conceito já foi feito no Discovery, para derrubar o risco de viabilidade técnica. Se mesmo assim o plano chegou aqui com alguma dúvida em aberto, ou alguma escolha entre dois caminhos, resolva agora, com o menor código possível que responda à pergunta.

**Nenhuma prova de conceito atravessa para a construção.** Todas morrem antes, com a resposta registrada em `decisoes.md`. Código de prova de conceito é jogado fora, nunca aproveitado.

**E se aparecer incerteza no meio da construção**, que ninguém tinha previsto: pare a fatia, faça a prova de conceito ali mesmo, responda a pergunta, mate o código e só então continue. Seguir construindo em cima de uma dúvida técnica é como levantar parede sem saber se o terreno aguenta.

## 2. Prepare o terreno

- Crie a estrutura do projeto dentro de `produto/`.
- Configure a esteira: branch `dev` para trabalho, `main` para produção.
- Configure a publicação automática: merge em `main` publica alguns instantes depois. É agora que `main` passa a publicar, não antes.
- Suba a infra definida no Discovery. Padrão: Cloudflare Pages, GitHub Actions, Supabase no plano gratuito.
- Instale **Sentry** e **PostHog**. Não é opcional, não é "depois". Sem isso, o Ciclo de Vida não tem o que analisar.

Para cada conta nova: abra a tela pelo Playwright, explique em uma frase para que serve, peça só que autentique, e assuma de volta. O builder nunca configura nada.

## 3. Construa por fatias

Quebre o plano em fatias verticais. Uma fatia é uma coisa inteira que funciona ponta a ponta, por menor que seja, não um pedaço solto que não faz nada sozinho.

Para cada fatia, nesta ordem, sem inverter:

1. **Escreva o teste primeiro**, a partir dos cenários que vieram do Discovery. Ele falha, e tem que falhar pelo motivo certo.
2. **Construa o mínimo que faz o teste passar.**
3. **Rode a suíte inteira.** Não só o teste novo: a fatia anterior não pode ter quebrado.
4. **Revise** com `code-review` do Matt Pocock, contra o padrão do projeto e contra o que o PRD pediu.
5. **Documente** o que mudou: arquitetura da fatia, decisão técnica com o porquê, e o status da tarefa (feita, em andamento, bloqueada) no rastreamento do projeto. Documentação técnica nasce junto com a fatia, não é tarefa de fechamento.
6. **Suba** para `dev`.

Use `tdd` do Matt Pocock como disciplina de construção. Ver [`dependencias.md`](../ai-squad/referencias/dependencias.md).

A suíte só cresce. Teste não se apaga porque ficou chato; se um teste incomoda, ou o código está errado ou o teste estava errado desde o começo, e as duas coisas se resolvem olhando, não deletando.

Quando a fatia envolver tela, chame `aisquad-design`. Quando a fatia coletar, guardar ou usar dado de pessoa, chame `aisquad-compliance`: consentimento, política de privacidade, direitos do titular e retenção nascem junto com o código, não depois.

Ao terminar cada fatia, diga o que já dá para fazer no produto. "Já dá para criar conta e entrar" vale mais do que qualquer contagem de tarefa.

## 4. Pagamento

Se o produto cobra, integre agora, no **modelo travado no Discovery**.

Se surgir motivo para mudar o modelo, pare e fale com o builder: trocar assinatura por pagamento único, ou o contrário, joga fora o que foi construído aqui. A decisão é do builder, com o custo na mesa.

Produto que cobra é criticidade alta por definição. Reclassifique se ainda não estiver.

## 5. Publique em desenvolvimento

O produto sobe para o ambiente de **desenvolvimento**, e só. Publique quantas vezes precisar: é lá que ele ganha corpo e é lá que o builder acompanha o que está nascendo.

**Produção fica travada nesta fase.** Nada de merge em `main`, nada de apontar domínio para o produto, nada de mandar link para ninguém de fora. Ver princípio 7 em [`principios.md`](../ai-squad/referencias/principios.md).

O motivo, e diga isso ao builder quando perguntar por que ainda não está no ar: o produto ainda não foi auditado. Colocar no ar antes disso significaria expor os dados de quem confiar no builder a uma brecha que ninguém procurou ainda. Falta uma fase, e ela é curta.

Verifique com os próprios olhos, no ambiente de desenvolvimento: acesse a URL, confirme que carrega, que o caminho principal funciona, que o Sentry recebe erro e que o PostHog recebe evento. Publicado não é o mesmo que funcionando.

Grave o endereço em `infra.url_desenvolvimento` no estado. É por ele que o builder acompanha o produto nascendo, e é ele que a próxima sessão usa para conferir se ainda está de pé.

## 6. Domínio, quando o produto vai viver na internet

Se a distribuição definida no Discovery é web, o produto precisa de endereço próprio. Você conduz isso inteiro.

**Escolha do nome**: a decisão é do builder. Traga três a cinco opções disponíveis, com o preço anual de cada uma, e explique o que muda entre `.com`, `.com.br` e as demais. Verifique a disponibilidade antes de mostrar, para o builder não se apegar a um nome que já é de outro.

**Compra**: conduza pelo Playwright até a tela do registrador. O builder preenche o pagamento e autentica, porque o cartão é do builder. Todo o resto é seu.

**DNS e certificado**: você configura, o builder não toca. Aponte o domínio para a hospedagem, configure os registros, confirme que o certificado de segurança foi emitido e que o endereço abre com cadeado.

**O domínio de verdade só passa a apontar para o produto quando a produção for liberada.** Até lá, ele fica reservado, ou apontando para uma página de espera. Comprar cedo é bom, porque bom nome acaba; publicar cedo, não.

Registre em `infra` no estado, pelo nome exato do campo: `dominio`, `dominio_registrador` e `dominio_vence_em` em DD/MM/AAAA. Domínio que expira derruba o produto sem aviso, e o builder não vai lembrar da data. Escrever em prosa no documento e esquecer o campo deixa o Ciclo de Vida sem o que vigiar.

## Quando o Delivery acaba

- Todas as fatias do plano construídas.
- Suíte inteira passando.
- Produto rodando em **desenvolvimento**, acessível, com o caminho principal funcionando.
- Sentry e PostHog recebendo dado de verdade.
- Domínio comprado e configurado, se o produto for web.
- Documentação técnica em dia: arquitetura de cada fatia, decisões com o porquê, e o status de cada tarefa refletindo a realidade, não uma foto de semanas atrás.
- `producao.liberada` continua `false`. A Qualidade e Segurança, que vem agora, aprova a auditoria mas também não libera: quem põe o produto no ar é o Lançamento, duas fases à frente.

Aí invoque `aisquad-qualidade`. O que você construiu ainda vai ser auditado por quem não confia em você, e é assim que tem que ser.

## Antes de virar a fase

Nesta ordem, sem pular nenhum:

1. `fases.delivery.status = "concluida"`, ou `"concluida_com_ressalva"` se ficou risco declarado ou lacuna aceita.
2. Todos os entregáveis de `delivery` com `feito: true` e o `caminho` preenchido.
3. `fase_atual = "qualidade"`.
4. `fases.qualidade.status = "em_andamento"`. Ela nasce `"nao_iniciada"`; sem isso o estado fica contraditório, com `fase_atual` apontando para uma fase que o próprio registro diz que não começou.
5. Atualize a fase do projeto em `~/.ai-squad/projetos.json`.
6. Regenere `estado.js`, atualize o painel e o README, e faça commit.

Só então invoque `aisquad-qualidade`. Pular o passo 3 deixa o projeto travado nesta fase para sempre, e a próxima sessão retoma no lugar errado.

**Nomes dos entregáveis**: use exatamente os nomes da tabela em [`estado.md`](../ai-squad/referencias/estado.md). Nunca invente nome nem escreva sem acento: o que vai para o estado aparece no painel exatamente como foi escrito.
