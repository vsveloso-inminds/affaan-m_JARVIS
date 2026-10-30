# PRD — JARVIS (fork InMinds)
> Versao: 1.0 | Data: 2026-10-30
> Status: Rascunho

> O PRD original do hackathon esta em `PRD.md` na raiz. Este documento descreve
> o que a InMinds quer extrair do fork. Preencher apos fechar DN-001.

---

## 1. Objetivo
Projeto upstream: apontar oculos inteligentes para uma pessoa e receber um dossie em segundos.
Pipeline: camera → deteccao facial (MediaPipe) → embedding (ArcFace) → busca reversa (PimEyes) →
enxame de agentes Browser Use (LinkedIn, X, Instagram, Google) + Exa → sintese por LLM → corkboard em tempo real.

Objetivo InMinds: **a definir** (DN-001). Hipotese de trabalho: absorver o padrao de orquestracao de
agentes e de UI em tempo real para reaproveitar em produtos proprios, sem o componente biometrico.

## 2. Personas

| Persona | Descricao | Necessidade principal |
|---|---|---|
| Time tecnico InMinds | Devs que vao estudar ou estender o codigo | Entender o orquestrador e o fluxo Convex em menos de uma hora |
| Vitor (CTO) | Decide se vira produto | Ver o pipeline rodando e estimar custo por consulta |

## 3. Escopo do MVP

### Funcional (deve funcionar end-to-end)
- [ ] Backend sobe local e reporta servicos disponiveis em `/api/services`
- [ ] Frontend sobe local e conecta no Convex
- [ ] Upload manual de foto dispara o pipeline em modo degradado (sem PimEyes)
- [ ] Enriquecimento por nome via Exa funciona isolado

### Fora do escopo (v1)
- Streaming dos oculos Meta Ray-Ban
- Uso de PimEyes ou qualquer busca reversa facial com terceiros (DT-003)
- Deploy publico

## 4. Regras de negocio
- Biometria facial so em laboratorio, com consentimento, com fotos do proprio time (DT-003)
- Toda chamada externa com timeout: 30 s para APIs, 180 s para agentes Browser Use (regra herdada)
- Nenhuma chave real em repositorio ou em deploy publico

## 5. Stack tecnica

| Camada | Tecnologia |
|---|---|
| Frontend | Next.js 16, React 19, Tailwind 4, Framer Motion 12 |
| Tempo real | Convex |
| Backend | FastAPI, Python 3.11+ |
| Visao | MediaPipe, insightface (ArcFace), ultralytics |
| Agentes | Browser Use (cloud), Exa API, twscrape |
| LLM | Anthropic Claude (primario), Gemini (fallback) |
| Observabilidade | Laminar |
| Persistencia | MongoDB Atlas |
| CI/CD | GitHub Actions → GHCR (backend) + Vercel (frontend) |

## 6. Criterios de aceite
- [ ] `GET /api/health` responde OK em ambiente local
- [ ] Pipeline degradado completa um dossie a partir de nome, sem rosto
- [ ] Custo por consulta estimado e registrado em decisions.md
- [ ] DN-001 fechada com objetivo claro
