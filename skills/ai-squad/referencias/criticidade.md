# Criticidade

Uma classificação, sete usos. É ela que decide o quanto o sistema aperta em cada situação.

## Quando classificar

Logo depois da visão estar clara, ainda no Discovery, antes de qualquer decisão de rigor. E de novo na virada de cada fase, porque um produto muda de natureza no caminho: no dia em que entra pagamento, ele sobe de faixa.

## Como classificar

Três perguntas, na ordem. A primeira que der "sim" define a faixa.

**Alta**
- Toca dinheiro de terceiro? Cobra, guarda, transfere, intermedia pagamento.
- Guarda dado sensível de gente? Saúde, documento, dado de criança, localização, conversa privada, biometria.
- Alguém pode se machucar, perder dinheiro ou ser exposto se isso funcionar errado?

**Média**
- Guarda conta e senha de usuário, ou dado pessoal comum como nome, e-mail e telefone?
- Outra pessoa além do builder depende disso para trabalhar?
- Tem receita envolvida, mesmo que pequena?

**Baixa**
- Nada acima. Produto que, quebrando, causa aborrecimento e nada além disso.

Na dúvida entre duas faixas, fique na mais alta. Errar para cima custa tempo; errar para baixo custa o produto.

Grave a faixa e o motivo em `estado.json`, em linguagem que o builder entenda. O motivo é o que você vai citar quando precisar apertar depois.

## Os sete usos

**1. Força da evidência exigida no Discovery.** O que muda por faixa é **quanto** de evidência basta, nunca **qual método** foi usado. Manifestação orgânica forte pode valer mais que cinco entrevistas mornas.

- **Alta**: exige evidência direta e específica desse público, e mais de uma fonte independente apontando o mesmo. Sinal indireto sozinho não derruba o risco de valor.
- **Média**: uma fonte de evidência de comportamento real basta, com o carimbo de onde ela veio.
- **Baixa**: sinal indireto serve, e você segue.

Em nenhuma faixa isso vira beco sem saída. Ver a seção "Como destravar" abaixo.

**2. Rigor da auditoria de segurança.** Alta: auditoria completa, todas as camadas, modo caixa-preta incluído. Média: auditoria completa sem o caixa-preta. Baixa: varredura do básico, que é o que cai primeiro no mundo real.

**3. AI Evals com humano.** Alta: eval automatizada não basta; o builder precisa revisar a amostra com os próprios olhos e você conduz isso passo a passo. Média e baixa: automatizada resolve.

**4. Confirmação de deploy.** Alta: toda ida para produção passa pelo builder. Média e baixa: o primeiro go-live passa pelo builder; manutenção depois sobe sozinha.

**5. Atrito do alerta de tiro no pé.** Alta: alerta crítico segura o trabalho até o builder confirmar de forma explícita e consciente. Média: alerta forte, uma insistência, registra e segue. Baixa: avisa, registra e segue.

**6. Escala do QA no ciclo de vida.** Alta: mudança pequena leva regressão completa mais revisão de segurança do que mudou; mudança estrutural leva auditoria inteira. Média: regressão completa e segurança focada. Baixa: regressão completa.

**7. Teste de carga.** Alta: sim, sempre. Média: só se houver expectativa real de volume. Baixa: não. Produto sem usuário não tem carga para testar, e gastar a assinatura nisso é desperdício.

## Como destravar sem afrouxar

Criticidade alta aperta, mas nunca prende. Quando o rigor exigir algo que o builder não consegue entregar na hora, principalmente conversa com usuário real, o caminho é este:

1. **Destrave ajudando.** Monte o roteiro da conversa, identifique onde essas pessoas estão, escreva a mensagem de abordagem, e conduza o builder até a conversa acontecer. Boa parte do "não consigo" é na verdade "não sei como".
2. **Insista duas vezes.** Mostre o que o builder está abrindo mão, com o risco concreto e específico do produto, não genérico.
3. **Aceite a decisão do builder.** Se o builder mantiver de forma consciente e ativa, registre em `riscos_declarados`, deixe o risco no nível alto que ele realmente está, marque no PRD que aquela mitigação não foi feita, e siga.

O sistema nunca mente dizendo que o risco foi mitigado. E nunca deixa o builder sem caminho.
