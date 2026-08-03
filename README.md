# AI-SQUAD

*Leia isto em [Português (Brasil)](README.pt-BR.md).*

A whole digital product squad, for people who are not in the field.

The person brings the idea and decides the direction. AI-SQUAD does the rest: finds out if the idea holds up, builds the product, tests it, secures it, ships it, puts together the launch, and stays on after the product is live.

No need to know what discovery, MVP, TDD, deploy or eval mean. The system drives.

> **Note on language**: AI-SQUAD is not a multilingual system. It runs, talks and writes every document in Brazilian Portuguese, by design (see Principles below): that is the whole point, a native-language squad for a non-technical, Portuguese-speaking builder.

## How it works

Before anything else comes **Setup**: installs the system on the machine, creates the project, opens the dashboard. It is not a product-building phase, it is tool installation, so it sits outside the pipeline below.

From there, five phases, in order, with the orchestrator driving start to finish.

| Phase | What happens | Delivers |
|-------|--------------|----------|
| **1. Discovery** | finds out if the idea holds up and how it becomes a product | PRD, prototype, technical plan |
| **2. Delivery** | builds test-first, publishes to a **development** environment, instrumented from day one | working product in development, technical docs up to date |
| **3. Quality** | audits the work and runs the security audit, then approves | approval, product still in development |
| **4. Launch** | builds the go-to-market strategy, produces the material, and **puts the product live for real** when the launch plan says so | go-to-market plan, assets, and the actual go-live |
| **5. Lifecycle** | follows up, fixes, and evolves | continuous cycle |

Discovery works through Marty Cagan's four product risks, and they are alive: all start high, and go down as the work removes uncertainty. Delivery is only recommended once all four reach moderate or low.

## Installation

**macOS and Linux**

```bash
bash instalador/instalar.sh
```

**Windows**

```powershell
powershell -ExecutionPolicy Bypass -File instalador\instalar.ps1
```

The installer copies the system to `~/.ai-squad`, installs the skills into `~/.claude/skills`, and checks dependencies. It does not install anything else: phase 0 handles that, explaining each step.

## How to use it

There is no command, keyword, or skill to invoke by hand. You just talk, in plain language, and Claude Code recognizes on its own that the request is about a product (that's how every skill works: each one describes what it's for, and Claude decides which one applies).

**New project, after the system is already installed**: open Claude Code in any folder (your desktop works fine) and say what you want to build: "I want to build an app that helps people organize their running training." AI-SQUAD takes over from there: creates the project folder, the private GitHub repository, and the dashboard, and starts at Discovery.

**Picking up a project that already exists**: open Claude Code inside that project's folder (or a folder above it) and say anything, even "hey, where did we leave off." The system looks for `.ai-squad/estado.json` on its own, reads the decision history in `decisoes.md`, and resumes exactly where it stopped, never asking what phase the project is in.

**Plugging into a project that existed before AI-SQUAD**: same thing, open Claude Code in the folder and say what you want. The system reads the code, the git history, the config files and whatever is already live, figures out on its own what stage the product is at, and enters at the right phase, without redoing what's done or skipping what's still missing.

In none of the three cases is there an "activate AI-SQUAD" step. Automatic detection is the product itself.

## The dashboard

Every project gets its own dashboard, at `.ai-squad/dashboard.html`. It's a self-contained HTML file, no server, no build step, no internet connection, that opens with two clicks in any browser.

It exists because the builder has no reason to take the system's word alone for how the project is going, and "open the terminal and tell me" is not something a non-technical person can do on their own three months later.

What it shows, in the example below of a fictional project ("Corrida Certa", a running-training app) in the Discovery phase:

- **The project's track**: the five phases, which one is done, which is in progress, which hasn't started.
- **The four product risks** from Marty Cagan (business, value, usability, technical viability), each with its current level and the reason in plain language, never jargon. All four start "high" and go down as Discovery gathers real evidence, exactly as in the example: technical viability already dropped to low, value dropped to moderate once market evidence showed up, business and usability are still high.
- **The current phase's deliverables**, what's done and what's missing.
- **What's waiting on the builder**: the next decision only they can make.
- **Risks the builder chose to accept**, when they decide to move forward without waiting for the evidence to come down on its own.
- **When all of this was last updated.**

![Example dashboard in the Discovery phase, showing the four product risks](docs/dashboard-preview.png)

The dashboard regenerates itself with every real step forward. The builder never edits this file by hand, and never needs to open it for the system to keep working: it's a complement, the conversation always stands on its own.

## What's inside

**Own skills**: the orchestrator (decides which phase to enter and never loses the thread), the six phases, and the design specialist that steps in whenever a slice involves a screen.

**Bundled specialists**, under `vendor/`, shipped copied on purpose instead of installed as an external dependency (the version that runs is the one that was tested; a dependency that updates itself changes behavior under the feet of someone who has no way to check it):

- **Skills For Real Engineers**, by Matt Pocock: test-first discipline (TDD), module design and code boundaries, domain modeling with architecture decision records, hard bug diagnosis, review against the project's own standard and against what was asked, logic prototyping before building, technical research against a trustworthy source, and merge-conflict resolution.
- **OpenPMStrategy**: five knowledge bases and 66 analytical tools for business strategy, including Mom Test (talking to users without confirmation bias), Lean Startup (validating an idea and designing an MVP), Hormozi (offer, pricing, guarantee, revenue model), Growth Systems (acquisition, retention, monetization), and Crossing the Chasm (adoption stage, positioning, channel).
- **Security Audit Agent v3**: full offensive security audit, three phases, seven specialized subagents, a two-layer threat model, black-box mode, infrastructure hardening.

None of these three specialists fires on its own as an independent skill: the orchestrator reads the right reference when the task calls for that discipline, applies it, and keeps driving. Two voices giving orders in the same session doesn't work, so there is only one.

**Tool**: `ferramentas/normalizar_html.py`, which converts any HTML's accented characters to escapes and guarantees the text never renders broken on screen.

## Principles

1. The builder decides the product. The system decides the engineering.
2. Clear, plain Brazilian Portuguese, as non-technical as possible, always.
3. Free and open tooling first.
4. Repository is always private.
5. Maintenance is autonomous. Evolution is approved.
6. Autonomy is measured by potential damage, not by appearance.
7. Never call done what isn't.

## How quality is guaranteed

Before anything goes to production, the product passes through independent layers:

1. **Quality audit** (phase 3): reviews the Delivery work against what was asked, applying Matt Pocock's test-first discipline.
2. **Security audit**: full offensive audit, three phases and seven specialized subagents, two-layer threat model, infrastructure hardening.
3. **Compliance audit**: when the product handles personal data, checks whether what is collected matches what the privacy policy declares, and whether data-subject rights actually work.
4. **AI behavior eval**, when the product has AI inside: a set of real cases with example good and bad answers, an automated judge calibrated against human review before it is trusted, and a lean cycle that runs the full set on the first two rounds and only retests what broke from there on.
5. **Production gate**: nothing ships without the first three approved. Not a recommendation, a lock, recorded in the project's state.

AI-SQUAD itself follows this discipline: the orchestrator's own guardrails (production lock under escalating pressure, refusal to skip a phase, resistance to prompt injection, among others) were measured across successive behavioral evaluation cycles, each fix compared scenario by scenario against the previous cycle before being accepted.

## License

MIT. Third-party components keep their own licenses, listed in [LICENSE](LICENSE).
