# .memory — JARVIS
> Fonte unica de verdade do estado do projeto.
> InMinds DNA v1.1.0 | Inicializado em 2026-10-30

---

## Projeto
- **Nome:** JARVIS (fork InMinds do projeto `affaan-m/JARVIS`, Web Agents Hackathon Browser Use + YC)
- **Stack:**
  - Frontend: Next.js 16.2 + React 19 + Tailwind 4 + Framer Motion 12 + Convex (tempo real). Testes: Vitest + Playwright
  - Backend: FastAPI (Python 3.11–3.13, uv) + MediaPipe + insightface/ultralytics + Browser Use + Exa + Anthropic/Gemini + Laminar + loguru. Testes: pytest + ruff
- **Repo:** https://github.com/vsveloso-inminds/affaan-m_JARVIS (origin)
- **Deploy:** GitHub Actions. Backend → imagem Docker no GHCR. Frontend → Vercel (gate por secret `VERCEL_TOKEN`)

## Regras
1. Arquivos aqui sao a verdade oficial
2. #temp.md e caixa de entrada — nunca e referencia
3. Datas sempre absolutas (nunca "semana que vem")
4. Um item, um lugar — nao duplicar entre arquivos
5. Historicos nao se editam — snapshots congelados
6. .memory/ com dados NUNCA e sobrescrito por atualizacoes

## Tipos de arquivo

| Tipo | Descricao | Quem edita | Frequencia |
|---|---|---|---|
| Vivo | Estado atual | Code | A cada sessao |
| Referencia | Documento base | Code (nova versao) | Raramente |
| Historico | Snapshot congelado | Ninguem | Nunca |
| Transicao | Temporario (#temp) | Usuario cola, Code processa | Sob demanda |
| Assets | Visuais promovidos | Code | Sob demanda |

## Indice

| Arquivo | Tipo | Descricao |
|---|---|---|
| README.md | Manifesto | Este arquivo |
| #temp.md | Transicao | Caixa de entrada |
| backlog.md | Vivo | Backlog unificado (InMinds). O backlog original do hackathon fica em `TASKS.md` na raiz |
| decisions.md | Vivo | Decisoes com justificativa |
| prd-v1.md | Referencia | PRD do projeto |
| handoff/ | Historico | Espelho para o Claude.ai Project (`/inm-dna-handoff`) |

## Documentacao herdada do upstream (raiz do repo)
Nao duplicar aqui. Referenciar.

| Arquivo | Conteudo |
|---|---|
| `.claude/CLAUDE.md` | Regras do autor original: research-before-build, stack travada, padroes de codigo, demo-first |
| `SYSTEM_DESIGN.md` | Design dos 4 modulos: captura, identificacao, agent swarm, sintese |
| `ARCHITECTURE.md` | Arquitetura geral |
| `TECH_DOC.md` | Schema Convex e contratos |
| `DESIGN_HANDOFF.md` | Tokens visuais, componentes, animacoes do corkboard |
| `TASKS.md` | Backlog original por fase (T01–T2x) |
| `PRD.md` | PRD original do hackathon |

## Workflow de entrada
1. Conteudo chega (reuniao, chat, Slack, outra IA)
2. Usuario cola no #temp.md
3. Code le, identifica destino, faz merge no arquivo certo
4. Code limpa #temp.md e confirma o que processou

## InMinds DNA
- Versao: 1.1.0
- Instalado em: 2026-10-30
- Skills globais: inm-per-claudin, inm-rol-cto, inm-rol-vendas, inm-dna-setup, inm-dna-handoff, inm-dna-skill-create, inm-plb-comercial, inm-plb-operacional, inm-prd-asaas, inm-prd-econet, inm-prd-protheus, inm-sec-predeploy, inm-utl-setup, inm-utl-skills, inm-utl-ss
