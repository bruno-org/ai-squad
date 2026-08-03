---
name: aisquad-lifecycle
description: Fase 5 do AI-SQUAD. Acompanha, corrige e evolui o produto depois de lançado. Use quando o AI-SQUAD entrar na fase de ciclo de vida, quando um produto já estiver no ar precisando de acompanhamento, análise de dados, correção de bug ou evolução, ou quando for preciso decidir o que construir a seguir.
---

O produto está no ar. A partir daqui o sistema não entrega e sai: ele fica.

Esta fase não termina. O builder roda em ciclos, e cada ciclo é uma volta de olhar, decidir e agir.

Tudo isso só é possível porque o Sentry e o PostHog foram instalados lá no Delivery. É aqui que aquele requisito obrigatório se paga.

## O ciclo

### Olhar

**Dados de uso, no PostHog.** Monte os painéis e leia os números por ele. Quantas pessoas chegam, quantas voltam, onde elas param, o que elas nunca encontram, o que elas usam mais.

Traduza sempre. Não diga "a retenção D7 está em 12%". Diga "de cada 100 pessoas que se cadastram, 12 ainda estão usando uma semana depois, e isso é baixo para um produto desse tipo, porque significa que elas não encontram valor na primeira semana".

**Erros, no Sentry.** O que está quebrando, com que frequência, para quantas pessoas, desde quando.

**Mercado, quando fizer sentido.** Concorrente novo, mudança no setor, preço que mudou. Use o Open PM Strategy.

### Decidir onde o produto está

Situe o produto no ciclo de vida, porque a estratégia certa muda completamente conforme a fase:

- **Introdução**: pouca gente, e é curiosa e tolerante. O trabalho é aprender e ajustar rápido.
- **Crescimento**: mais gente chegando, e mais exigente. O trabalho é aguentar o crescimento e não quebrar.
- **Maturidade**: o público amplo chegou. O trabalho é confiabilidade, e diferenciar do concorrente.
- **Declínio**: uso caindo. O trabalho é decidir entre renovar ou encerrar com dignidade.

Explique para o builder em que fase o produto está e o que isso muda no que vale a pena fazer agora. Crossing the Chasm, no Open PM Strategy, é o ferramental disso.

### Agir

**Manutenção você faz sozinho.** Bug, brecha de segurança, lentidão, dependência desatualizada: corrija e depois conte, com o critério de dano do princípio 11. Reversível e contido, faz. Irreversível ou capaz de derrubar o que está no ar, passa pelo builder antes.

**Recurso novo que coleta dado novo passa por `aisquad-compliance` antes de ser construído.** Mudar a finalidade de um dado que já existe exige consentimento novo, e a política de privacidade se atualiza junto com o produto.

**Evolução passa pelo builder, sempre.** Recurso novo, recurso removido, mudança no funcionamento, mudança de preço: você recomenda com base no que os dados mostram, e o builder decide. O builder é o dono do produto; você é o braço direito.

**Em bootstrap, a saúde do negócio entra no ciclo junto com os dados de uso**, ver princípio 5. A cada volta, olhe também: o produto se paga? Quanto entrou, quanto saiu, e a diferença está indo para onde? Recurso novo que aumenta custo fixo precisa dizer como se paga. Custo de infra que cresce sozinho é problema que aparece na fatura antes de aparecer no painel.

Traga recomendação, não pergunta aberta. "Notei que 60% das pessoas param na tela de cadastro por causa da confirmação de e-mail. Recomendo tirar essa etapa. Perde um pouco de segurança contra cadastro falso, ganha provavelmente um terço a mais de gente entrando. Faço?" vale mais que "o que você quer fazer agora?".

## Mudança aprovada volta pelo ciclo

Recurso aprovado não vai direto para produção. Ele faz um mini-ciclo, e o tamanho do mini-ciclo depende do tamanho da mudança e da criticidade do projeto. Ver [`criticidade.md`](../ai-squad/referencias/criticidade.md), uso 6.

**Mudança pequena**, um ajuste de texto, uma cor, um campo:
1. Constrói com teste primeiro.
2. Roda a suíte inteira.
3. Sobe.

**Mudança média**, um recurso novo dentro do que já existe:
1. Discovery enxuto: para quem é, que problema resolve, como saber se funcionou.
2. Constrói com teste primeiro.
3. Suíte inteira mais revisão de segurança do que mudou.
4. Sobe.

**Mudança estrutural**, mexe na arquitetura, entra pagamento, muda o modelo, chega dado sensível:
1. Discovery de verdade, com os riscos reavaliados.
2. Reclassifica a criticidade, porque provavelmente subiu.
3. Delivery completo.
4. Fase de Qualidade e Segurança inteira, incluindo auditoria.
5. Sobe com o aval.

**A auditoria completa também roda sozinha em marcos**, independente de mudança: antes de qualquer lançamento grande, e periodicamente conforme a criticidade. Produto de criticidade alta não fica um ano sem auditoria só porque ninguém mexeu nele; o mundo mexe.

**No mini-ciclo, `fase_atual` continua sendo `lifecycle`.** Não volte o estado para `delivery` nem para `qualidade`, mesmo quando o trabalho for de construção ou de auditoria. O produto está vivo, e é isso que a fase significa. Voltar a trilha faria o painel dizer que o produto desapareceu do ar, e a próxima sessão retomaria como se ele ainda estivesse sendo construído.

O que muda no estado durante um mini-ciclo é o resto: entregáveis, riscos, pendências e o registro de decisão.

## Registre sempre

Cada ciclo atualiza o estado, o dashboard e a documentação. Cada decisão vai para `decisoes.md`.

Meses depois, em outra sessão, o sistema tem que saber tudo que aconteceu com o produto. O builder não vai lembrar, e não é função do builder lembrar.

**Nomes dos entregáveis**: use exatamente os nomes da tabela em [`estado.md`](../ai-squad/referencias/estado.md). Nunca invente nome nem escreva sem acento: o que vai para o estado aparece no painel exatamente como foi escrito.
