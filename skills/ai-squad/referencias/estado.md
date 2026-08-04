# O estado do projeto

O estado é a memória do projeto e a única fonte da verdade. Ele existe porque uma sessão de Claude Code compacta, esquece e acaba, e o projeto dura meses.

## Onde fica

Dentro da pasta do projeto, em `.ai-squad/`:

```
.ai-squad/
  estado.json      fonte da verdade, legivel por voce
  estado.js        a mesma coisa, para o dashboard ler no navegador
  decisoes.md      o registro do porque de cada decisao
  dashboard.html   a tela que o builder abre
```

`estado.js` é o mesmo conteúdo de `estado.json` dentro de `window.ESTADO = {...}`. Existe porque o navegador bloqueia leitura de JSON em arquivo local, mas carrega script sem reclamar. **Escreva os dois juntos, sempre.** Se divergirem, o dashboard mente.

## O formato

```json
{
  "projeto": {
    "nome": "",
    "descricao_curta": "",
    "criado_em": "AAAA-MM-DD",
    "modo": "novo | existente",
    "criticidade": "baixa | media | alta",
    "criticidade_motivo": "",
    "financiamento": "bootstrap | investido",
    "idioma_do_produto": "pt-BR"
  },
  "fase_atual": "bootstrap | discovery | delivery | qualidade | gtm | lifecycle",
  "fases": {
    "bootstrap": { "status": "concluida" },
    "discovery": {
      "status": "nao_iniciada | em_andamento | concluida | concluida_com_ressalva",
      "entregaveis": {
        "PRD": { "feito": false, "caminho": "" },
        "Protótipo": { "feito": false, "caminho": "" },
        "Plano técnico": { "feito": false, "caminho": "" }
      }
    },
    "delivery":  { "status": "nao_iniciada" },
    "qualidade": { "status": "nao_iniciada" },
    "gtm":       { "status": "nao_iniciada" },
    "lifecycle": { "status": "nao_iniciada" }
  },
  "riscos": {
    "negocio":    { "nivel": "alto", "motivo": "", "atualizado_em": "" },
    "valor":      { "nivel": "alto", "motivo": "", "atualizado_em": "" },
    "usabilidade":{ "nivel": "alto", "motivo": "", "atualizado_em": "" },
    "viabilidade":{ "nivel": "alto", "motivo": "", "atualizado_em": "" }
  },
  "riscos_declarados": [],
  "lacunas": [],
  "infra": {
    "repositorio": "",
    "hospedagem": "",
    "banco": "",
    "observabilidade": "",
    "analytics": "",
    "dominio": "",
    "dominio_registrador": "",
    "dominio_vence_em": "",
    "url_desenvolvimento": "",
    "url_producao": ""
  },
  "producao": {
    "liberada": false,
    "liberada_em": "",
    "auditoria_referencia": ""
  },
  "links": [],
  "pendencias_para_ela": [],
  "trabalho_interrompido": null,
  "ultima_atualizacao": ""
}
```

## Regras de escrita

**Todo risco nasce em `alto`.** Ele só desce quando alguma coisa concreta removeu incerteza. O campo `motivo` explica o nível em linguagem que o builder entende: "alto porque você ainda não conversou com nenhuma pessoa que teria esse problema". O motivo aparece no dashboard, então escreva pensando em quem vai ler.

### Todo item de lista carrega `descricao`

`riscos_declarados`, `lacunas`, `pendencias_para_ela` e `trabalho_interrompido` são lidos pelo painel pela chave **`descricao`**, que traz a frase completa que o builder vai ler na tela. Os outros campos do item são estruturais, existem para o sistema, e podem variar.

**Item sem `descricao` aparece no painel como estrutura de dado crua.** Não é degradação elegante: é o builder olhando `{"entregavel":"PRD","fase":"discovery"}` no meio da tela. A frase vem primeiro, sempre.

```json
"riscos_declarados": [
  { "descricao": "Você decidiu seguir sem conversar com usuário, e o risco de valor continua alto.",
    "risco": "valor", "nivel": "alto", "data": "02/08/2026" }
],
"lacunas": [
  { "descricao": "Falta o PRD do Discovery, então ainda não dá para recomendar crescimento com base em nada.",
    "entregavel": "PRD", "fase": "discovery" }
],
"pendencias_para_ela": [
  { "descricao": "Conversar com 5 pessoas que tenham o problema. Eu monto o roteiro e digo onde encontrá-las." }
],
"trabalho_interrompido": {
  "descricao": "A auditoria de segurança parou na metade e ainda não terminou.",
  "trabalho": "auditoria de seguranca", "coberto": "camada de rede e autenticacao"
}
```

**`riscos_declarados`** guarda o risco que o builder decidiu conscientemente não mitigar. Esse registro nunca some, nem quando o risco for mitigado depois.

**`lacunas`** guarda o que ficou faltando para trás, usado em projeto que veio de fora.

**`trabalho_interrompido`** é preenchido antes de começar qualquer trabalho longo (auditoria de segurança, suíte de testes grande, varredura completa) e limpo só quando ele termina de verdade. Se a sessão morre no meio, a próxima encontra isso preenchido e retoma. Enquanto estiver preenchido, o dashboard mostra o trabalho como incompleto e você nunca diz que ele foi feito.

**`pendencias_para_ela`** é o que só o builder pode resolver: autenticar numa conta, conversar com uma pessoa, aprovar um deploy, decidir um rumo. É o que o dashboard mostra em destaque.

**`producao.liberada`** é a trava mais importante do estado. Nasce `false` e só vira `true` no **Lançamento**, no momento do go-live, com o aval do builder. Enquanto for `false`, nenhum caminho leva a produção: sem merge em `main`, sem domínio apontado, sem link divulgado. Ver princípio 7.

**Aprovar e publicar são dois campos e duas fases.** A Qualidade e Segurança destrava o portão e escreve `producao.auditoria_referencia`, com o produto ainda em desenvolvimento; ela nunca escreve `producao.liberada`. Quem atravessa o portão é o Lançamento, quando o cronograma do plano de lançamento chegar nesse ponto. Nenhuma outra fase escreve nestes campos: se você está no Delivery e sente vontade de liberar, a resposta é não.

**`projeto.financiamento`** nasce `bootstrap` e só vira `investido` se o builder disser que a empreitada tem investidor, sócio capitalista, fomento ou subsídio. Ele existe para a sessão de daqui a três meses não precisar perguntar de novo, e porque a lente de negócio inteira muda com ele: em `bootstrap` a conta é quando isso se paga, em `investido` a conta admite prejuízo planejado. Ver princípio 5.

**`infra.dominio_vence_em`** existe porque domínio vencido derruba o produto sem aviso e o builder não vai lembrar da data. No Ciclo de Vida, avise quando estiver perto.

**Os campos de `infra` e de `producao` se escrevem pelo nome exato.** Eles são fáceis de descrever em prosa e esquecer de gravar, e aí o painel e a sessão seguinte ficam sem a informação:

| Campo | Quem escreve | Quando |
|-------|--------------|--------|
| `infra.url_desenvolvimento` | Delivery | ao publicar em desenvolvimento pela primeira vez |
| `infra.dominio_registrador` | Delivery | ao comprar o domínio |
| `infra.dominio_vence_em` | Delivery | ao comprar o domínio, em DD/MM/AAAA |
| `producao.auditoria_referencia` | Qualidade | ao aprovar a auditoria, com o produto ainda em desenvolvimento |
| `producao.liberada` | Lançamento | no go-live, com o aval do builder |
| `producao.liberada_em` | Lançamento | no go-live, em DD/MM/AAAA |
| `infra.url_producao` | Lançamento | no go-live, depois de confirmar que o endereço abre |

## Os entregáveis de cada fase

Use exatamente estes nomes como chave em `entregaveis`. O painel traduz variações conhecidas, mas escrever certo na origem evita o problema em vez de remediá-lo.

| Fase | Entregáveis |
|------|-------------|
| bootstrap | `Ambiente preparado`, `Projeto criado`, `Repositório` |
| discovery | `Visão`, `Estratégia`, `ICP`, `Lean Canvas`, `Modelagem financeira`, `Pesquisa`, `PRD`, `Protótipo`, `Plano técnico`, `Cenários de teste`, `Quatro Ps`, `Compliance e LGPD` |
| delivery | `Infraestrutura`, `Observabilidade`, `Analytics`, `Pagamento`, `Domínio`, `Política de privacidade`, `Suíte de testes`, `Produto em desenvolvimento` |
| qualidade | `Relatório de qualidade`, `Auditoria de segurança`, `Evals de IA`, `Auditoria de conformidade` |
| gtm | `Reconciliação`, `Plano de lançamento`, `Material operacional`, `Produto em produção` |
| lifecycle | `Painéis de dados` |

Liste só os entregáveis que a fase realmente vai produzir. Produto sem IA não tem `Evals de IA`; produto que não cobra não tem `Pagamento`.

**Entregável rastreado não é o mesmo que gate de saída.** A lista acima existe para o builder acompanhar o progresso no painel, item a item. O que autoriza a fase a fechar é o gate escrito na skill da fase, que costuma ser um subconjunto. No Discovery, por exemplo, todos os doze aparecem no painel, mas o gate são os três finais (`PRD`, `Protótipo`, `Plano técnico`) mais os quatro riscos em moderado ou baixo.

## Como escrever o texto que o builder vê

Todo campo de texto do estado aparece no painel, então cada um é conteúdo voltado para o builder, não anotação interna:

- **Português com acentuação correta**, sempre. Sem travessão.
- **Frase completa, com ponto final**, nos campos de `motivo`, `descricao` e equivalentes.
- **Primeira letra maiúscula**, e nome próprio e sigla na caixa certa.
- **Sem jargão**. "Você ainda não conversou com ninguém que tenha esse problema" serve; "validação qualitativa pendente" não.

## A virada de fase

Este é o ponto do estado que mais quebra se for esquecido, porque tudo depende dele: o painel, a retomada da sessão meses depois, e o registro global.

**Ao terminar uma fase, antes de invocar a próxima, execute os cinco passos, nesta ordem:**

1. Marque a fase que acabou: `fases.<fase>.status = "concluida"`. Se a fase fechou com risco declarado ou lacuna aceita, use `"concluida_com_ressalva"`.
2. Marque todos os entregáveis do builder com `feito: true` e o `caminho` preenchido.
3. Mude `fase_atual` para a chave da próxima fase.
4. Marque a fase nova: `fases.<nova_fase>.status = "em_andamento"`. Ela nasceu `"nao_iniciada"`; sem este passo o estado fica contraditório, `fase_atual` aponta para uma fase que o próprio registro diz que não começou.
5. Atualize a fase do projeto em `~/.ai-squad/projetos.json`.

Só depois disso invoque a skill da fase seguinte.

Esquecer o passo 3 ou o passo 4 é o pior erro possível neste sistema: o projeto fica com o estado contraditório ou eternamente marcado na fase antiga, o painel mostra a trilha errada, e a próxima sessão retoma no lugar errado. O painel deduz o passado a partir de `fase_atual`, então ele é o eixo de tudo.

## Quando escrever

A cada avanço real, e sempre antes de encerrar a sessão. Escrever estado é barato; perder contexto de três meses de trabalho não é.

Depois de escrever o estado, regenere `estado.js`, atualize o README do projeto se algo mudou nele, registre a decisão em `decisoes.md` se houve decisão, e faça commit.

## O registro de decisões

`decisoes.md` guarda o porquê, que é justamente o que se perde quando um documento é atualizado. Uma entrada por decisão:

```markdown
## D-001: Título curto da decisão
Data: DD/MM/AAAA
Fase: discovery
Decidido por: builder | sistema

O que foi decidido, em uma ou duas frases.

Por que: o raciocínio e as alternativas que ficaram para trás.
```

Quando o Go-to-Market reconciliar a fonte da verdade e atualizar documento do Discovery, o documento muda e este registro **não**. É ele que impede o PRD final de mentir sobre como o projeto realmente aconteceu.
