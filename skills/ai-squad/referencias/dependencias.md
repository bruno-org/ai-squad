# O que você tem dentro de casa

Três sistemas prontos vivem em `~/.ai-squad/vendor/`, instalados junto do AI-SQUAD. Eles não são o processo; são especialistas que você chama quando a tarefa é do feitio deles. Você continua conduzindo.

## Matt Pocock: engenharia de software

`~/.ai-squad/vendor/mattpocock-skills/`

Disciplina de engenharia de verdade, não vibe coding solto. Atua no **Discovery**, no **Delivery** e no **Ciclo de Vida**. No Go-to-Market não serve.

| Quando | Use |
|--------|-----|
| Desenhar arquitetura e definir onde ficam as fronteiras dos módulos | `codebase-design` |
| Fixar o vocabulário do projeto e registrar decisão de arquitetura | `domain-modeling` |
| Construir qualquer coisa, sempre | `tdd` |
| Bug difícil, lentidão, algo que quebrou e ninguém sabe por quê | `diagnosing-bugs` |
| Revisar o que foi construído contra o padrão e contra o que foi pedido | `code-review` |
| Testar uma ideia de estado ou de tela antes de construir para valer | `prototype` |
| Levantar fato técnico em fonte confiável | `research` |
| Conflito de merge no meio do caminho | `resolving-merge-conflicts` |

`tdd` é o padrão de construção, não uma opção entre outras. Teste primeiro, fatia vertical, suíte que só cresce.

## Open PM Strategy: estratégia de negócio

`~/.ai-squad/vendor/openpmstrategy/`

Cinco bases de conhecimento e 66 ferramentas analíticas. Atua no **Discovery**, no **Go-to-Market** e no **Ciclo de Vida**.

| Base | Serve para |
|------|-----------|
| Mom Test | conversar com usuário, separar sinal de elogio, fatiar segmento, achar quem realmente tem a dor |
| Lean Startup | validar ideia, desenhar MVP, decidir entre insistir e mudar de rumo, métrica que não é vaidade |
| Hormozi | oferta, preço, garantia, modelo de receita, nome |
| Growth Systems | aquisição, retenção, monetização, experimento, psicologia de uso |
| Crossing the Chasm | fase de adoção, público de cada fase, posicionamento, canal, produto completo |

**Três regras de uso, e elas não são negociáveis:**

0. **A premissa de financiamento é descartada.** Essas bases nasceram no mundo de capital de risco, onde queimar dinheiro para crescer é estratégia e o sucesso se mede em rodada levantada. Aqui o padrão é bootstrap, ver princípio 5. Use o ferramental, que é bom: entrevista do Mom Test, oferta e preço do Hormozi, posicionamento do Crossing the Chasm, retenção do Growth Systems. Ignore o que só faz sentido com investidor atrás: métrica de vaidade para deck, crescimento a qualquer custo, "capture o mercado agora e monetize depois", tamanho de mercado inflado para justificar rodada. Quando a base recomendar gastar para crescer, traduza para o que cabe no bolso do builder.

1. **Ele não assume a sessão.** O documento original dele manda tomar controle total. Aqui não. Você lê as bases, aplica o framework e volta a conduzir. Quem fala com o builder é você.
2. **Saída vai para a pasta do projeto.** O original salva na área de trabalho em DOCX, XLSX e PDF. Aqui, análise vira Markdown dentro da pasta da fase, versionado no repositório. Documento de negócio em formato de escritório só quando for apresentar para alguém de fora, e mesmo assim uma cópia, não o original.

## Auditoria de Segurança v3: segurança

`~/.ai-squad/vendor/seguranca-v3/`

Auditoria ofensiva completa, três fases, sete subagentes especializados. Atua na **Qualidade e Segurança** e no **Ciclo de Vida**.

**Três coisas mudam em relação ao documento original:**

1. **Modo invisível desligado.** O original esconde rastro, salva relatório fora do projeto e disfarça commit de correção. Aquilo existe para auditar sistema de terceiro. Aqui o produto é do builder: relatório dentro da pasta do projeto, correção documentada, commit com mensagem honesta.
2. **Autonomia de correção redefinida.** O original exige autorização a cada mudança. Aqui vale o princípio 11: reversível e de dano contido, você corrige e reporta; irreversível ou capaz de derrubar o que está no ar, passa pelo builder. O critério é o dano, não a aparência.
3. **Progresso gravado.** Antes de começar, preencha `trabalho_interrompido` no estado. Só limpe quando a matriz de cobertura fechar. Sessão que morre no meio não pode virar produto declarado seguro.

O rigor da auditoria segue a faixa de criticidade. Ver [`criticidade.md`](criticidade.md), uso 2.

## O que a máquina do builder já tem

Além destes três, olhe o que existe na sessão: outras skills, MCPs conectados, ferramentas instaladas. Use o que ajudar.

**Regra de uso**: leitura você faz livre. Qualquer coisa com efeito no mundo, ou seja, publicar, cobrar, apagar, enviar, mexer em produção ou em credencial, passa pelo builder antes.

**Regra de dependência**: nada que você encontrou na máquina do builder pode virar pré-requisito de etapa nenhuma. O sistema funciona inteiro só com o perfil-base. O resto é ganho, nunca condição.
