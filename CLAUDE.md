# CLAUDE.md — JARVIS (fork InMinds)
> Briefing obrigatorio. Lido em toda sessao.
> InMinds DNA v1.1.0 | Inicializado em 2026-10-30

---

## Projeto
- **Nome:** JARVIS. Plataforma de inteligencia sobre pessoas em tempo real. Fork InMinds de `affaan-m/JARVIS` (Web Agents Hackathon, Browser Use + YC)
- **Stack:** Next.js 16 + React 19 + Tailwind 4 + Framer Motion + Convex | FastAPI + MediaPipe + insightface + Browser Use + Exa + Anthropic/Gemini + Laminar
- **Repo:** https://github.com/vsveloso-inminds/affaan-m_JARVIS
- **Deploy:** GitHub Actions. Backend → Docker no GHCR. Frontend → Vercel (so com `VERCEL_TOKEN` configurado)

## Regras herdadas do upstream
O autor original deixou regras em `.claude/CLAUDE.md`. Elas continuam valendo, em especial:
- Research before build: procurar lib existente antes de escrever codigo
- Stack travada (RULE 3): nao trocar sem aprovacao explicita
- Timeout em toda chamada externa: 30 s API, 180 s agente Browser Use
- Demo-first: fallback para todo caminho fragil

Em conflito entre este arquivo e `.claude/CLAUDE.md`, este prevalece. Ver DT-002.

## Restricao InMinds (inviolavel)
**Biometria facial so em laboratorio, com consentimento, com fotos do proprio time.**
Nada de PimEyes com terceiros, nada de demo publica, nada de deploy com chaves reais ate a avaliacao LGPD fechar (BL-007, DT-003).

## Estrutura
```
backend/          FastAPI. capture/ identification/ agents/ synthesis/ enrichment/ db/ observability/ memory/ eval/ tests/
frontend/         Next.js app router. app/ components/ convex/ lib/
HumanDetection/   Deteccao de pessoas (ultralytics)
samples/          Midias de teste
scripts/          Utilitarios
.claude/          Regras, skills e guardrails do upstream (ECC bundle)
.agents/          Agentes DNA (code-reviewer, test-writer, doc-generator) + skill JARVIS do upstream
.memory/          Estado do projeto (InMinds DNA)
```

## Como rodar
```bash
cp .env.example .env            # preencher chaves; backend sobe sem elas em modo degradado
cd backend && uv sync && uv run uvicorn main:app --reload --port 8000
cd frontend && npm install && npm run dev && npx convex dev
```
Checagem: `GET /api/health` e `GET /api/services`.

## .memory/
Este projeto usa InMinds DNA para gestao de estado.
- Backlog: `.memory/backlog.md` (o backlog tecnico original do hackathon esta em `TASKS.md`)
- Decisoes: `.memory/decisions.md`
- PRD: `.memory/prd-v1.md` (o original esta em `PRD.md`)
- Caixa de entrada: `.memory/#temp.md`
- Handoff de contexto: `.memory/handoff/` (gerado por `/inm-dna-handoff`)

## Regras
1. Leia este arquivo antes de qualquer acao
2. Atualize .memory/ a cada sessao relevante
3. Registre decisoes em decisions.md com DT-XXX ou DN-XXX
4. Use #temp.md como caixa de entrada — processe e limpe
5. Nunca sobrescreva .memory/ com dados sem backup
6. O Claude.ai Project e espelho, nao fonte. Nunca edite o contexto la —
   rode `/inm-dna-handoff` e substitua o arquivo anterior
7. Commits em conventional commits (`feat:`, `fix:`, `chore:`, `docs:`), padrao ja usado no repo

## InMinds DNA
- Versao: 1.1.0
- Instalado em: 2026-10-30
