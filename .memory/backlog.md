# Backlog — JARVIS
> Arquivo vivo. Atualizado a cada sessao.
> Ultima atualizacao: 2026-10-30

---

## Convencao
- BL-XXX — Item avulso (sequencial global)
- EF-XXX — Especificacao funcional
- EF-XXX.Y — Sub-item de uma EF

## Status
- ✅ Entregue | 🔄 Em andamento | ⏳ Pendente | ❌ Cancelado | 🚫 Bloqueado

> O backlog tecnico original do hackathon (T01–T2x, por fase) esta em `TASKS.md` na raiz.
> Este arquivo cobre o que a InMinds faz com o fork. Nao duplicar os T-itens aqui.

---

## Herdado do upstream (ultimos commits antes do fork)

| ID | Item | Status | Inicio | Fim | Notas |
|---|---|---|---|---|---|
| BL-001 | Deploy workflow: gate por secret do Vercel corrigido | ✅ Entregue | — | 2026-05-19 | commit 4369c34 |
| BL-002 | Bump idna e langsmith no backend (grupo uv) | ✅ Entregue | — | 2026-05-19 | commits 4b3685d, 9c1d69a |
| BL-003 | CI: hardening de supply chain nos workflows (actions pinadas por SHA) | ✅ Entregue | — | 2026-05-13 | commit 127efab |
| BL-004 | Docs: prompt defense baseline no `.claude/CLAUDE.md` | ✅ Entregue | — | 2026-05-12 | commit a092e34 |
| BL-005 | Bundle ECC (guardrails, identity, instincts) adicionado | ✅ Entregue | — | 2026-05-11 | commit 9f023e4 |

## Fase 1 — Estudo de referencia (DN-001, parte 1)

| ID | Item | Status | Inicio | Fim | Notas |
|---|---|---|---|---|---|
| BL-006 | Definir o objetivo da InMinds com este fork | ✅ Entregue | 2026-10-30 | 2026-10-30 | DN-001: estudo + base B2B sem biometria |
| BL-014 | Provisionar VM de laboratorio isolada (Azure, RG proprio, Docker, desligavel) e chaves de API proprias do lab | 🔄 Em andamento | 2026-10-30 | — | DT-004. Nao roda no PC do Vitor nem na VPS de producao |
| BL-008 | Subir backend e frontend no lab via `docker compose` e validar `/api/health` e `/api/services` | 🔄 Em andamento | 2026-10-30 | — | Compose e Dockerfile do frontend prontos no repo. Depende de BL-014 para executar |
| BL-009 | Inventario de chaves necessarias e custo por consulta (Browser Use, Exa, Convex, Laminar, SuperMemory). PimEyes fora | ⏳ Pendente | — | — | Alimenta a viabilidade da Fase 2 |
| BL-010 | Rodar `/inm-dna-handoff` e criar o Claude.ai Project do JARVIS | 🔄 Em andamento | 2026-10-30 | — | Primeiro espelho |
| BL-011 | Mapear o orquestrador (`backend/agents/orchestrator.py`, `pipeline.py`): tiers, paralelismo, timeouts, streaming para Convex | ⏳ Pendente | — | — | Entregavel: documento curto em `.memory/` com o padrao extraido |
| BL-012 | Mapear o fluxo de tempo real Convex → corkboard (`frontend/convex/`, `components/`) | ⏳ Pendente | — | — | Entregavel: padrao de UI reativa para reaproveitar |
| BL-013 | Rodar o pipeline em modo degradado a partir de um nome, sem rosto, e medir latencia e custo | ⏳ Pendente | — | — | Depende de BL-008 e BL-009 |

## Fase 2 — Base para enriquecimento B2B sem biometria (DN-001, parte 2)

| ID | Item | Status | Inicio | Fim | Notas |
|---|---|---|---|---|---|
| EF-001 | Enriquecimento B2B por empresa/CNPJ: entrada textual, agentes em LinkedIn/site/Google/Exa, dossie da empresa e decisores | ⏳ Pendente | — | — | Especificar apos BL-011 e BL-013 |
| EF-001.1 | Remover do caminho de produto: `identification/` (facial, PimEyes), `agents/account_manager.py` (criacao de contas falsas), `agents/darkweb_agent.py` | ⏳ Pendente | — | — | Em lab continuam ligados (DT-003). No produto, removidos, nao escondidos |
| EF-001.2 | Trocar a entrada "foto" por "empresa (CNPJ) + nome do decisor" no frontend | ⏳ Pendente | — | — | — |
| EF-001.4 | Reescrever a lista de fontes para o Brasil: Receita (CNPJ/QSA), Jusbrasil, Diarios Oficiais, Reclame Aqui, noticias BR, LinkedIn BR, site da empresa. Internacionais atras de toggle do operador | ⏳ Pendente | — | — | DT-005 |
| EF-001.3 | Avaliar Convex vs Supabase para a versao produto | ⏳ Pendente | — | — | Reabre DT-001 so nesta fase |
| BL-007 | Avaliacao LGPD do fluxo B2B (dados de decisores sao pessoais, mesmo sem biometria) | ⏳ Pendente | — | — | Pre-requisito para qualquer uso com cliente. Ver DT-003 |

---

## Timesheets

| Bloco | Inicio | Fim | Duracao | Itens |
|---|---|---|---|---|
| Clone + DNA setup | 2026-10-30 00:32 | 2026-10-30 00:50 | ~20 min | clone, leitura de docs, .memory/, CLAUDE.md, .agents/ |

---

## Futuro (ideias)

| ID | Item | Origem |
|---|---|---|
| FT-001 | Reaproveitar o pipeline de agent swarm (Exa + Browser Use + sintese) para enriquecimento de leads B2B por CNPJ/empresa, sem biometria | Claudin, 2026-10-30 |
| FT-002 | Reaproveitar o corkboard UI (Convex + Framer Motion) como padrao de dashboard investigativo em outros produtos InMinds | Claudin, 2026-10-30 |
| FT-003 | Conectar o modulo de deteccao de pessoas (`HumanDetection/`, ultralytics) ao ecossistema InSecurity (NeoVigia, VigiaCloud) | Claudin, 2026-10-30 |
