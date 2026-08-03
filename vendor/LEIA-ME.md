# Dependências contidas

Três sistemas prontos vivem aqui dentro, copiados de propósito em vez de instalados como dependência externa.

**Por que copiados**: a máquina precisa rodar a versão que foi testada. Dependência que se atualiza sozinha muda o comportamento embaixo dos pés de quem não sabe conferir. Aqui a versão fica fixa e sobe quando alguém revisar.

**Como são usados**: como **referência lida sob demanda**, não como skill que dispara sozinha. O orquestrador do AI-SQUAD lê o arquivo do especialista quando a tarefa é do feitio dele, aplica a disciplina, e continua conduzindo.

Isso é deliberado. Se essas skills fossem registradas como skills de verdade, elas dispariam por conta própria e passariam a competir com o processo do AI-SQUAD, com dois orquestradores dando ordens diferentes na mesma sessão. Como referência, o AI-SQUAD mantém o comando.

Se a máquina por acaso tiver o plugin do Matt Pocock instalado, melhor: as skills dele viram alcançáveis diretamente e o AI-SQUAD usa. Mas nada aqui **depende** disso.

---

## mattpocock-skills

Origem: https://github.com/mattpocock/skills, versão 1.2.0. Licença MIT, Copyright (c) 2026 Matt Pocock. Licença preservada em `mattpocock-skills/LICENSE`.

Usadas em Discovery, Delivery e Ciclo de Vida. No Go-to-Market não servem.

| Arquivo | Para quê |
|---------|----------|
| `engineering/tdd/SKILL.md` | disciplina de construção padrão, teste primeiro, fatia vertical |
| `engineering/codebase-design/SKILL.md` | desenhar módulo e decidir onde ficam as fronteiras |
| `engineering/domain-modeling/SKILL.md` | fixar vocabulário do projeto e registrar decisão de arquitetura |
| `engineering/diagnosing-bugs/SKILL.md` | bug difícil, lentidão, algo quebrado sem causa aparente |
| `engineering/code-review/SKILL.md` | revisar contra o padrão e contra o que foi pedido |
| `engineering/prototype/SKILL.md` | testar ideia de lógica antes de construir |
| `engineering/research/SKILL.md` | checar fato técnico em fonte confiável |
| `engineering/resolving-merge-conflicts/SKILL.md` | conflito de merge |
| `productivity/teach/SKILL.md` | base do modo professor |
| `productivity/grilling/SKILL.md` | entrevistar a fundo até alinhar de verdade |

**Não usadas**, e de propósito: `implement`, `wayfinder`, `to-spec`, `to-tickets`, `triage` e `improve-codebase-architecture` trazem processo próprio de ponta a ponta, que competiria com as fases do AI-SQUAD. `ask-matt` e `setup-matt-pocock-skills` só fazem sentido no repositório original. `writing-great-skills` serve parao builder o AI-SQUAD, não para quem o usa.

---

## openpmstrategy

Origem: repositório próprio da ProdMan. Licença MIT, Copyright (c) 2026 ProdMan.

Cinco bases de conhecimento e 66 ferramentas analíticas. Usado em Discovery, Go-to-Market e Ciclo de Vida.

O catálogo completo está em `openpmstrategy/strategy-original.md`. As bases ficam em `openpmstrategy/knowledge-bases/`, cada uma com frameworks, princípios e prompts de especialista.

| Base | Serve para |
|------|-----------|
| `mom-test-knowledge-base` | conversar com usuário, separar sinal de elogio, fatiar segmento |
| `lean-startup-knowledge-base` | validar ideia, desenhar MVP, decidir entre insistir e mudar de rumo |
| `hormozi-knowledge-base` | oferta, preço, garantia, modelo de receita, nome |
| `growth-systems-knowledge-base` | aquisição, retenção, monetização, experimento |
| `crossing-the-chasm-knowledge-base` | fase de adoção, público de cada fase, posicionamento, canal |

### Duas mudanças em relação ao original

**1. Ele não assume a sessão.** O documento original manda tomar controle total e falar direto com o usuário até resolver. Aqui não. Você lê as bases, aplica o framework, e volta a conduzir. Quem fala com o builder é o AI-SQUAD, com a mesma voz do começo ao fim.

**2. A saída vai para a pasta do projeto.** O original salva na área de trabalho, em DOCX, XLSX e PDF, e proíbe Markdown. Aqui é o contrário: análise vira Markdown dentro da pasta da fase, versionada no repositório, porque é assim que a narrativa do projeto se mantém amarrada. Documento em formato de escritório só quando for apresentar para alguém de fora, e como cópia, nunca como original.

---

## seguranca-v3

Origem: Agente de Auditoria de Segurança Full-Stack v3, da ProdMan. Arquivo em `seguranca-v3/agente-original.md`.

Auditoria ofensiva completa: três fases, sete subagentes especializados, modelo de ameaça em duas camadas, modo caixa-preta, hardening de infraestrutura.

Usado na fase de Qualidade e Segurança e no Ciclo de Vida.

### Três mudanças em relação ao original

**1. Modo invisível desligado.** A seção 22 do original manda salvar o relatório fora do projeto, disfarçar commit de correção e não deixar rastro. Aquilo existe porque o agente foi desenhado para auditar sistema de terceiro com discrição.

Aqui o produto é do builder. Relatório em `03-qualidade/`, dentro do projeto, versionado. Correção documentada. Commit com mensagem honesta dizendo o que corrigiu. Esconder trabalho de segurança do dono do sistema não faz sentido neste contexto.

**2. Autonomia de correção redefinida.** O original exige autorização explícita a cada mudança, o que travaria o sistema em cada achado e frustraria a regra de corrigir de imediato.

Aqui vale o critério de dano: reversível e de estrago contido, corrige e reporta; irreversível ou capaz de derrubar o que está no ar, passa por o builder antes, mesmo que não mude nada na tela. E toda correção que muda o que a pessoa vê passa por o builder sempre, com o risco de não fazer explicado em linguagem natural.

**3. Progresso gravado.** O original roda de cabo a rabo sem parar. Numa assinatura com limite de uso, isso significa auditoria morrendo no meio.

Aqui, antes de começar, preenche-se `trabalho_interrompido` no estado do projeto, atualizado conforme avança e limpo só quando a matriz de cobertura fecha. Sessão que morre no meio é retomada de onde parou, e enquanto isso o painel mostra a auditoria como incompleta. Auditoria pela metade nunca se apresenta como concluída.

### O que fica igual

Todo o resto: o rigor, a completude, o modelo de ameaça em duas camadas, os subagentes, a varredura do básico antes do sofisticado, e a camada de tradução do diagnóstico para linguagem natural. Essa última, aliás, é exatamente o que o AI-SQUAD precisa, e já vinha pronta.
