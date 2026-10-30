# JARVIS — Contexto do repositorio

Gerado em 2026-10-30 por `/inm-dna-handoff`. Espelho do estado real do repositorio para o Claude.ai Project. Nunca editar a mao.

| Campo | Valor |
|---|---|
| Branch | main |
| Ultimo commit | 8828313 (2026-10-30) chore: add InMinds DNA v1.1.0 |
| Base do delta | 4369c34 (2026-05-19), ultimo commit do upstream antes do fork |
| Commits no total | 93 |
| Handoff anterior | nenhum |

Fontes lidas: `CLAUDE.md`, `.claude/CLAUDE.md`, `.claude/rules/JARVIS-guardrails.md`, `README.md`, `AGENTS.md`, `.env.example`, `backend/pyproject.toml`, `backend/uv.lock`, `backend/config.py`, `backend/main.py`, `backend/env_check.py`, `backend/identification/embedder.py`, `backend/synthesis/*.py`, `frontend/package.json`, `frontend/package-lock.json`, `frontend/convex/schema.ts`, `.github/workflows/*.yml`, `.memory/*.md`, `TASKS.md`, `git log`.

Nada foi inferido de fora do repositorio. O que nao pode ser confirmado esta marcado como `nao verificado`.

---

## 1. Identidade

| Campo | Valor confirmado | Onde |
|---|---|---|
| Nome do produto | JARVIS | `README.md:1`, commit ef33ac0 (2026-03-18) |
| Grafias anteriores | SPECTER (fev/2026), CIRI (28/02/2026), YC_hackathon (nome da pasta original) | commits 6d2694e, ef33ac0; `.claude/skills/YC_hackathon/` |
| O que e | Plataforma de inteligencia sobre pessoas em tempo real: camera dos oculos ou foto, reconhecimento facial, enxame de agentes de browser, dossie sintetizado por LLM, corkboard ao vivo | `README.md:3-5` |
| Origem | Web Agents Hackathon (Browser Use + YC), fevereiro de 2026 | `README.md:7`, primeiro commit 0928b41 em 2026-02-28 |
| Autor upstream | affaan-m | `AGENTS.md:3` (caminho `/Users/affoon/...`), PR #1 |
| Dono do fork | InMinds Technology (vsveloso-inminds) | `git remote -v` |
| Objetivo do fork | Estudo de referencia do padrao de agent swarm + base para enriquecimento B2B sem biometria | `.memory/decisions.md` DN-001 |
| Repositorio | https://github.com/vsveloso-inminds/affaan-m_JARVIS | `git remote -v` |
| Branches | so `main` (local e remota) | `git branch -r` |
| Deploy backend | Imagem Docker publicada no GHCR por GitHub Actions | `.github/workflows/deploy.yml:11-45` |
| Deploy frontend | Vercel por GitHub Actions, so roda se `VERCEL_TOKEN` existir | `.github/workflows/deploy.yml:47-95` |
| URL canonica | nao definida no repositorio | `nao verificado` |
| Projeto Vercel vinculado | nenhum arquivo `vercel.json`, `vercel.ts` ou `.vercel/` | busca na raiz e em `frontend/` |
| Atividade | 55 commits em fev/2026, 27 em mar/2026, 10 em mai/2026 (so dependencias e CI), 1 em out/2026 (DNA InMinds). Parado como produto desde 2026-03-18 | `git log` por mes |

---

## 2. Stack real

`node_modules/` e `.venv/` nao estao instalados nesta maquina. A coluna "Instalado" usa os lockfiles (`uv.lock`, `package-lock.json`), que sao a melhor evidencia disponivel.

### 2.1 Backend (Python)

| Camada | Pacote | Declarado (`pyproject.toml`) | Lockfile | Docs afirmam | Divergencia |
|---|---|---|---|---|---|
| Framework | fastapi | >=0.116.0 | 0.134.0 | FastAPI | nao |
| Runtime | python | >=3.11, <3.14 | Dockerfile `python:3.11-slim` | 3.11+ | nao |
| Gestor | uv | `uv.lock` presente | — | README manda `pip install -e .`; CI usa `uv sync` | README desatualizado |
| Deteccao facial | mediapipe | >=0.10.32 | 0.10.32 | MediaPipe | nao |
| Deteccao de pessoas | ultralytics (YOLO) | >=8.3.0 | 8.4.19 | nao citado no README | README omite |
| Embedding facial | insightface | **nao declarado** | ausente | README e `.claude/CLAUDE.md` afirmam ArcFace/insightface | **SIM. `embedder.py:2` diz "Stub implementation", embedding e hash. Ver secao 7** |
| Busca reversa | PicImageSearch | >=3.12.11 | — | PimEyes + PicImageSearch | nao |
| Agentes de browser | browser-use, browser-use-sdk | >=0.12.0, >=2.0.15 | 0.12.6 | Browser Use cloud | nao |
| Busca rapida | exa-py | >=2.6.1 | 2.6.1 | Exa API | nao |
| LLM primario | anthropic | >=0.52.0 | 0.76.0 | README: "Claude 3.5 Sonnet" | **Codigo usa `claude-sonnet-4-6`** (`anthropic_engine.py:198`) |
| LLM fallback | google-genai | >=1.60.0 | 1.65.0 | Gemini 2.0 Flash | `.claude/CLAUDE.md` RULE 3 diz que Gemini e o primario. Codigo e README dizem Anthropic primario |
| Twitter | twscrape | >=0.17.0 | 0.17.0 | twscrape | nao |
| Observabilidade | lmnr (Laminar) | >=0.7.40 | 0.7.44 | Laminar | nao |
| Logs | loguru | >=0.7.3 | — | loguru | nao |
| Email de agente | agentmail | >=0.2.22 | 0.2.22 | nao citado | README omite. 1 import real (`agents/agentmail_client.py`) |
| LangChain | langchain-openai | >=0.3.0 | 1.2.1 | nao citado | 1 import real. Uso pontual |
| Telegram | python-telegram-bot | >=22.6 | — | Telegram bot | nao |
| Streaming | sse-starlette | >=1.8.0 | — | SSE | nao |
| Persistencia | pymongo / motor | **nao declarado** | ausente | README, AGENTS.md e `.claude/CLAUDE.md` afirmam MongoDB Atlas | **SIM. Nenhum cliente MongoDB no codigo. So `MONGODB_URI` em `config.py` e um rotulo em `main.py:249`** |
| Memoria longa | supermemory | nao declarado (usa httpx direto) | — | SuperMemory | nao. `memory/supermemory_client.py` chama a API via httpx |
| Testes | pytest, pytest-cov, ruff | extra `dev` | — | — | cobertura minima no CI: 46% (`ci.yml:54`) |

Dependencias declaradas com zero imports no codigo (fora de testes): nenhuma. Todas as checadas tem ao menos um import.

### 2.2 Frontend (TypeScript)

| Camada | Pacote | Declarado | Lockfile | Docs afirmam | Divergencia |
|---|---|---|---|---|---|
| Framework | next | 16.2.6 | 16.2.6 | Next.js 16 | nao |
| UI | react, react-dom | 19.2.3 | 19.2.3 | — | nao |
| CSS | tailwindcss | ^4 | 4.2.1 | Tailwind CSS | nao |
| Animacao | framer-motion | ^12.34.3 | 12.34.3 | Framer Motion | nao. 4 arquivos importam |
| Tempo real | convex | ^1.32.0 | 1.32.0 | Convex | nao. 11 arquivos importam |
| Icones | lucide-react | ^0.575.0 | — | — | 4 arquivos importam |
| Gestos | @use-gesture/react | ^10.3.1 | — | — | **Zero imports. Dependencia morta** |
| Testes unidade | vitest, testing-library | ^4.0.18 | 4.0.18 | — | 4 arquivos de teste em `src/components/__tests__/` |
| Testes e2e | @playwright/test | ^1.58.2 | 1.58.2 | — | 1 spec em `frontend/e2e/smoke.spec.ts` |
| Lint | eslint 9 + eslint-config-next | — | — | — | nao |

### 2.3 Servicos externos e variaveis de ambiente

`backend/config.py` declara 27 settings. `.env.example` documenta 16. As 11 abaixo existem no codigo e **nao estao no `.env.example`**:

| Variavel | Para que | Onde |
|---|---|---|
| ANTHROPIC_API_KEY | LLM primario de sintese | `config.py` |
| SIXTYFOUR_API_KEY | Enriquecimento SixtyFour.ai | `config.py:45`, `enrichment/sixtyfour_client.py` |
| HIBP_API_KEY | Have I Been Pwned (agente OSINT) | `config.py` |
| DAYTONA_API_KEY, DAYTONA_API_URL | Sandbox | `config.py` |
| HUD_API_KEY | Avaliacao HUD | `config.py`, `eval/hud_eval.py` |
| AGENTMAIL_API_KEY | Email de agente | `config.py` |
| PIMEYES_EMAIL, PIMEYES_PASSWORD | Conta unica PimEyes (alem do pool) | `config.py` |
| BROWSER_USE_PROFILE_ID | Perfil autenticado no Browser Use cloud | `config.py`, commit e434c12 |
| OP_VAULT_ID | Cofre 1Password | `config.py` |

Servicos pagos no caminho completo: Browser Use cloud, Exa, PimEyes (pool de contas), Convex, Laminar, SuperMemory, Anthropic, Gemini, SixtyFour. Custo por consulta ainda nao medido (BL-009).

---

## 3. Arquitetura

### 3.1 Backend (FastAPI)

Modulos em `backend/` (arquivos `.py` fora `__init__`):

| Modulo | Arquivos | Papel |
|---|---|---|
| `capture/` | audio_handler, frame_extractor, frame_handler, service, telegram_bot, webhook | Entrada: frames dos oculos, video, Telegram, webhook, audio por WebSocket |
| `identification/` | detector, embedder, human_detector, pimeyes, reverse_search, search_manager | MediaPipe, YOLO, embedding (stub), PimEyes via Browser Use, busca reversa |
| `agents/` | orchestrator, deep_researcher, browser_use_client, browser_agent, linkedin_agent, twitter_agent, instagram_agent, google_agent, social_agent, osint_agent, darkweb_agent, url_scraper_agent, account_manager, agentmail_client, cloud_skills | Enxame de agentes Browser Use e orquestracao em dois tiers |
| `enrichment/` | exa_client, sixtyfour_client | Fast-pass por nome |
| `synthesis/` | engine (Gemini), anthropic_engine (Claude), connections | Dossie estruturado e deteccao de conexoes entre pessoas |
| `memory/` | supermemory_client | Cache de dossies |
| `db/` | convex_client, memory_gateway | Escrita no Convex. Nao ha cliente MongoDB |
| `observability/` | laminar | Spans de tracing |
| `eval/` | hud_eval | Avaliacao de qualidade do dossie |
| raiz | main, pipeline, config, schemas, tasks, env_check, demo | App, pipeline, settings, contratos Pydantic |
| `tests/` | 20 arquivos | pytest, cobertura minima 46% no CI |

Rotas da API (`main.py` + router `capture/webhook.py` com prefixo `/api/capture`):

| Rota | Metodo | Frente |
|---|---|---|
| `/api/health` | GET | Saude |
| `/api/services` | GET | Quais integracoes tem chave |
| `/api/pipeline/status` | GET | Estado do pipeline |
| `/api/tasks` | GET | Tarefas em andamento |
| `/api/capture` | POST | Upload de imagem, dispara pipeline |
| `/api/capture/frame` | POST | Frame dos oculos, deteccao YOLO |
| `/api/capture/identify` | POST | Identificacao a partir de face |
| `/api/capture/url` | POST | Captura a partir de URL (via router) |
| `/api/capture/webhook` | POST | Webhook generico de captura (via router) |
| `/api/person/{person_id}` | GET | Dossie de uma pessoa |
| `/api/research/{person_name}/stream` | GET | SSE do enriquecimento por nome |
| `/api/agents/research` | POST | Dispara agentes Browser Use |
| `/api/agents/sessions/{session_id}` | GET | Estado de sessao do Browser Use |
| `/api/webhooks/browser-use` | POST | Callback do Browser Use cloud |
| `/ws/audio/{room_code}` | WebSocket | Comandos de voz, transcricao Gemini |

### 3.2 Tempo real (Convex)

`frontend/convex/schema.ts`, 5 tabelas: `captures`, `persons`, `intelFragments`, `connections`, `activityLog`. Funcoes em `captures.ts`, `persons.ts`, `intel.ts`, `connections.ts`. Nenhuma tabela nova desde a base do delta.

### 3.3 Frontend (Next.js, App Router)

Codigo em `frontend/src/`, nao em `frontend/app/` como diz `.claude/CLAUDE.md` RULE 5.

| Area | Arquivos |
|---|---|
| Paginas | `src/app/page.tsx` (unica pagina), `src/app/layout.tsx` |
| Rotas de API Next | nenhuma |
| Componentes (12) | IntelBoard, Corkboard, PersonCard, ConnectionLine, DossierView, Sidebar, StatusBar, TopBar, LiveFeed, CameraFeed, CaptureButton, BrowserSessionViewer |
| Hooks (13) | useJarvisData, useSafeConvexQuery, useResearchStream, useSessionPoller, useGlassesStream, useFrameCapture, useVoiceCommands, useServerVoice, useVoiceSynthesis, useSoundEffects, useAchievements |
| Lib | api.ts (cliente REST do backend), types.ts, demo-data.ts (fallback sem backend) |

### 3.4 Fora do framework

| Componente | Onde | Papel |
|---|---|---|
| HumanDetection | `HumanDetection/human_detection.py` | Deteccao de pessoas com YOLO, standalone |
| Swarm launcher | `scripts/swarm-launch.sh` | Sobe multiplos agentes |
| Dockerfile | `backend/Dockerfile` | `python:3.11-slim` |
| CI | `.github/workflows/ci.yml` | backend: `uv sync`, `ruff check`, `pytest --cov-fail-under=46`. frontend: `npm ci`, `npm audit signatures`, `npm audit --audit-level=high`, `npm test` |
| Seguranca | `codeql.yml`, `dependency-review.yml` | Actions pinadas por SHA desde 127efab |
| ECC bundle | `.claude/` (rules, skills, homunculus, identity.json, ecc-tools.json) | Guardrails gerados por ferramenta externa em 2026-05-11 |
| Codex | `AGENTS.md`, `.codex/` | Instrucoes para Codex apontando para `.claude/CLAUDE.md` |
| DNA InMinds | `CLAUDE.md` (raiz), `.memory/`, `.agents/*.md` | Adicionado em 8828313 |

---

## 4. Decisoes

Fonte: `.memory/decisions.md`. Numeracao sem lacunas e sem duplicidade. Proximos IDs livres: DT-004, DN-002.

### 4.1 Tecnicas

| ID | O que | Por que | Data | Status |
|---|---|---|---|---|
| DT-001 | Stack herdada do upstream mantida como esta | Trocar antes de saber o objetivo do fork e retrabalho. `.claude/CLAUDE.md` RULE 3 trava a stack | 2026-10-30 | Vigente. Reabre em EF-001.3 (Convex vs Supabase) |
| DT-002 | `CLAUDE.md` da raiz e o briefing InMinds e prevalece. `.claude/CLAUDE.md` do upstream fica intacto | Rastreabilidade do que e nosso e facilidade de puxar do upstream | 2026-10-30 | Vigente |
| DT-003 | Nenhum uso do pipeline facial fora de laboratorio ate avaliacao LGPD. So fotos do time, com consentimento, local | Biometria e dado sensivel (LGPD art. 5 II e art. 11). Risco juridico e reputacional | 2026-10-30 | Vigente, inviolavel |

### 4.2 Negocio

| ID | O que | Por que | Data | Status |
|---|---|---|---|---|
| DN-001 | Objetivo do fork em duas partes: (1) estudo de referencia do agent swarm e da UI em tempo real; (2) base para enriquecimento B2B por empresa/CNPJ sem biometria | Valor reaproveitavel esta no orquestrador e na UI, nao no facial. B2B tem demanda no pipeline comercial InMinds | 2026-10-30 | Vigente. Decisao do Vitor. Descartado: demo para InSecurity |

Decisoes implicitas do upstream (nao estao em `decisions.md`, estao em `.claude/CLAUDE.md` RULE 3): Gemini como modelo de visao, pipeline MediaPipe + ArcFace + PimEyes, VisionClaw para captura, Exa tier 1 e Browser Use tier 2, Convex para tempo real, MongoDB para persistencia. Duas delas divergem do codigo (ArcFace e MongoDB, secao 7).

---

## 5. Backlog

Fonte: `.memory/backlog.md`. O backlog tecnico do hackathon continua em `TASKS.md` (2 de 34 itens marcados, mas o codigo mostra muito mais entregue; `TASKS.md` nao foi mantido).

### 5.1 Entregue

| ID | Item | Fim |
|---|---|---|
| BL-001 | Deploy workflow: gate por secret do Vercel corrigido | 2026-05-19 |
| BL-002 | Bump idna e langsmith no backend | 2026-05-19 |
| BL-003 | CI: hardening de supply chain (actions por SHA) | 2026-05-13 |
| BL-004 | Prompt defense baseline no `.claude/CLAUDE.md` | 2026-05-12 |
| BL-005 | Bundle ECC adicionado | 2026-05-11 |
| BL-006 | Objetivo do fork definido (DN-001) | 2026-10-30 |

### 5.2 Em andamento

| ID | Item | Proximo passo |
|---|---|---|
| BL-010 | Primeiro handoff e Claude.ai Project | Este arquivo. Anexar ao Project e commitar |

### 5.3 Pendente (Fase 1, estudo)

| ID | Item | Depende de |
|---|---|---|
| BL-008 | Subir backend e frontend local, validar `/api/health` e `/api/services` | — |
| BL-009 | Inventario de chaves e custo por consulta | — |
| BL-011 | Mapear o orquestrador: tiers, paralelismo, timeouts, streaming para Convex | — |
| BL-012 | Mapear o fluxo Convex para corkboard | — |
| BL-013 | Rodar pipeline degradado a partir de nome, sem rosto, medir latencia e custo | BL-008, BL-009 |

### 5.4 Pendente (Fase 2, base B2B)

| ID | Item | Depende de |
|---|---|---|
| EF-001 | Enriquecimento B2B por empresa/CNPJ | BL-011, BL-013 |
| EF-001.1 | Isolar `identification/` atras de flag | — |
| EF-001.2 | Entrada "empresa + decisor" no lugar de foto | — |
| EF-001.3 | Avaliar Convex vs Supabase para a versao produto | — |
| BL-007 | Avaliacao LGPD do fluxo B2B | Pre-requisito para uso com cliente |

### 5.5 Bloqueado

Nenhum item bloqueado.

---

## 6. Linha do tempo

So marcos. Ignorados fix, chore, style, ci e bumps de dependencia.

### Fevereiro de 2026 (28/02, hackathon)

| Hash | Marco |
|---|---|
| 0928b41 | Primeiro commit |
| d3b2713, 9654273 | Documentos de design, regras do projeto, integracao VisionClaw |
| 248081f | Scaffold do app e automacao GitHub |
| 2e3b5c9 | Convex em tempo real com fallback de demo |
| 21c4984 | Contratos de adaptadores tipados (Protocol + Pydantic) |
| fc3140b, 21fe8ab, 260ecaa | Pipeline captura para board, Exa + Gemini, costura com enriquecimento e sintese |
| 09f15c7 | Telegram bot e webhook de captura |
| 2b2d208 | Agentes OSINT, darkweb e social |
| e3fa817, 58016e6, eff69ee | Animacoes Framer Motion, deteccao de conexoes, corkboard |
| ad6f89e | Laminar e Browser Use v2 cloud |
| 8e7ff6b, c4c9963 | Claude como fallback, depois como primario de sintese. SuperMemory, HUD eval, face cropping |
| 5d10514 | Browser Use cloud em todos os agentes |
| c145b32 | `/api/capture/frame` com YOLO |
| 6d2694e | Rebrand SPECTER para CIRI |
| e1ee991 | PR #1 mesclada (ECC tools) |

### Marco de 2026

| Hash | Marco |
|---|---|
| f4aef2e, d719578 | Cliente Browser Use Cloud, API de pesquisa por agente, BrowserSessionViewer |
| ba61add | DeepResearcher unificado, SixtyFour.ai, SSE, eliminacao de falsos positivos |
| 91409f4 | Camada de hardware: VisionClaw iOS/Android, WebRTC, YOLO |
| d38b9d5 | Dossie renderizado, observabilidade, secrets, streaming |
| e434c12 | Autenticacao por `profile_id` no Browser Use (sessao unica) |
| 6e020a5 | Comandos de voz pelos oculos, gamificacao na UI |
| 7e13666, a4d1d44 | Backend resiliente com degradacao graciosa; health checks e estados de erro no frontend |
| ef33ac0 | Rename CIRI para JARVIS |
| f41073e | README de onboarding |

### Maio de 2026

| Hash | Marco |
|---|---|
| 9f023e4 | PR #9: bundle ECC (guardrails, identity, instincts) |
| 37ed8a8, 006863b, 127efab | PRs #10 e #11: hardening de supply chain no frontend e nos workflows |
| a092e34 | Prompt defense baseline |
| 4369c34 | Gate de secret no deploy. Ultimo commit do upstream |

### Outubro de 2026

| Hash | Marco |
|---|---|
| 8828313 | InMinds DNA v1.1.0: `CLAUDE.md`, `.memory/`, `.agents/`. Primeiro commit do fork |

PRs mescladas: #1, #8, #9, #10, #11, #14. PRs fechadas sem merge: nao verificavel pelo clone (precisa da API do GitHub).

---

## 7. Delta e obsolescencia

### 7.1 O que os documentos antigos afirmam e o codigo contradiz

| Documento ou termo | Situacao | Substituto ou realidade |
|---|---|---|
| "ArcFace embeddings (insightface)" em `README.md`, `.claude/CLAUDE.md` RULE 2 e RULE 3 | **Falso.** `embedder.py:1-2` declara stub; o embedding e um hash. insightface nao esta no `pyproject.toml` | Identificacao real depende so de PimEyes + busca reversa. Sem embedding, nao ha comparacao local de rostos |
| "MongoDB Atlas" como persistencia em `README.md`, `AGENTS.md`, `.claude/CLAUDE.md` RULE 3 | **Nao implementado.** Nenhum cliente MongoDB. So a variavel `MONGODB_URI` e um rotulo em `main.py:249` | Persistencia efetiva e Convex (tempo real) + SuperMemory (cache de dossies) |
| "Claude 3.5 Sonnet" em `README.md:14` | Desatualizado | `claude-sonnet-4-6` em `anthropic_engine.py:198` |
| "Vision model: Gemini 2.0 Flash (vision + synthesis)" em `.claude/CLAUDE.md` RULE 3 | Parcialmente obsoleto | Sintese primaria e Anthropic desde c4c9963. Gemini e fallback (429) e transcricao de voz |
| `frontend/app/` em `.claude/CLAUDE.md` RULE 5 e `AGENTS.md` | Caminho errado | Codigo esta em `frontend/src/app/`, `src/components/`, `src/hooks/`, `src/lib/` |
| `pip install -e .` em `README.md` | Desatualizado | Projeto usa `uv` (`uv.lock`, CI com `uv sync --extra dev`) |
| `.env.example` com 16 variaveis | Incompleto | `config.py` tem 27. Faltam 11 (secao 2.3), incluindo `ANTHROPIC_API_KEY`, que e o LLM primario |
| `TASKS.md` com 2 de 34 itens marcados | Abandonado | O codigo entrega a maior parte das fases 1 a 4. Nao usar como medida de progresso |
| `@use-gesture/react` em `package.json` | Dependencia morta | Zero imports. Candidata a remocao |
| Nomes SPECTER e CIRI | Historicos | JARVIS desde ef33ac0. `.claude/skills/YC_hackathon/` e `.claude/homunculus/.../YC_hackathon-instincts.yaml` ainda usam o nome da pasta original |
| "Built for the Web Agents Hackathon" como proposito | Verdadeiro para o upstream, nao para o fork | Proposito InMinds e DN-001 |

### 7.2 O que existe hoje e nao existia na base do delta (4369c34)

| Item | Commit |
|---|---|
| `CLAUDE.md` na raiz com briefing InMinds e restricao LGPD | 8828313 |
| `.memory/` com README, backlog, decisions, prd-v1, #temp, handoff/ | 8828313 |
| `.agents/code-reviewer.md`, `test-writer.md`, `doc-generator.md` | 8828313 |
| Este handoff e `.memory/handoff/config.yaml` | nao commitado ainda |

Nenhuma mudanca de codigo desde a base do delta.

### 7.3 Regras vigentes que qualquer contexto novo precisa respeitar

| Regra | Fonte |
|---|---|
| Biometria facial so em laboratorio, com consentimento, com fotos do proprio time. Sem PimEyes com terceiros, sem demo publica, sem deploy com chaves reais ate BL-007 | `CLAUDE.md` raiz, DT-003 |
| Em conflito entre `CLAUDE.md` (raiz) e `.claude/CLAUDE.md`, o da raiz prevalece | DT-002 |
| Research before build: procurar lib existente antes de escrever codigo, documentar a decisao em comentario no topo do arquivo | `.claude/CLAUDE.md` RULE 1 |
| Stack travada: nao trocar sem aprovacao explicita | `.claude/CLAUDE.md` RULE 3, DT-001 |
| Toda chamada externa com timeout: 30 s para API, 180 s para agente Browser Use. Try/except com log. Nenhum agente derruba o pipeline | `.claude/CLAUDE.md` RULE 4 |
| Python com type hints e loguru. TypeScript strict com interfaces de props | `.claude/CLAUDE.md` RULE 4 |
| `ruff check` limpo e cobertura de testes acima de 46% no backend. `npm audit --audit-level=high` limpo no frontend | `.github/workflows/ci.yml` |
| Conventional commits (`feat:`, `fix:`, `chore:`, `docs:`) | `.claude/rules/JARVIS-guardrails.md`, `CLAUDE.md` raiz regra 7 |
| Nunca editar o contexto no Claude.ai Project. Rodar `/inm-dna-handoff` e substituir o arquivo | `CLAUDE.md` raiz regra 6 |
| Backend sobe sem chaves e degrada por servico. Nao quebrar isso | commit 7e13666, `README.md` |
| Demo-first: todo caminho fragil tem fallback | `.claude/CLAUDE.md` RULE 8 |
| Nenhuma chave real em repositorio ou deploy publico | `.memory/prd-v1.md` secao 4 |

---

## Rodape

| Verificacao | Resultado |
|---|---|
| Build local | nao executado nesta maquina (`node_modules/` e `.venv/` ausentes) |
| Ultimo CI conhecido | nao verificavel pelo clone. Workflow `ci.yml` roda ruff, pytest com cobertura minima 46%, npm audit e vitest |
| Erros de tipo | nao verificado |
| Paginas geradas | 1 (`src/app/page.tsx`) |
| Arvore git | limpa exceto `.memory/handoff/` |
