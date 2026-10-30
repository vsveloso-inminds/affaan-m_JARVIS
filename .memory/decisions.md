# Decisoes — JARVIS
> Arquivo vivo. Registra decisoes com justificativa.
> Ultima atualizacao: 2026-10-30

---

## Formato
- **O que:** o que foi decidido
- **Por que:** justificativa / contexto
- **Quando:** data
- **Alternativas descartadas:** o que foi considerado e rejeitado

---

## Decisoes Tecnicas

### DT-001 — Stack herdada do upstream, mantida como esta
- **O que:** Manter a stack do projeto original: Next.js 16 + React 19 + Tailwind 4 + Framer Motion + Convex no frontend. FastAPI + MediaPipe + insightface + Browser Use + Exa + Anthropic/Gemini + Laminar no backend. Deploy via GitHub Actions (GHCR + Vercel).
- **Por que:** Detectado no projeto existente. O `.claude/CLAUDE.md` do autor trava essas escolhas na RULE 3. Trocar stack antes de saber o objetivo do fork (DN-001) e retrabalho sem retorno.
- **Quando:** 2026-10-30
- **Alternativas descartadas:** Migrar Convex para Supabase (stack padrao InMinds). Fica para depois de DN-001. Convex resolve o tempo real sem WebSocket custom e esta funcionando.

### DT-002 — InMinds DNA convive com as regras do autor original, sem sobrescrever
- **O que:** `CLAUDE.md` na raiz e o briefing InMinds. `.claude/CLAUDE.md` continua intacto como regras do upstream. Os dois sao lidos pelo Claude Code. Em conflito, o da raiz (InMinds) prevalece por ser o dono do fork.
- **Por que:** O upstream traz regras boas (research-before-build, timeouts em toda chamada externa, demo-first) que nao vale reescrever. Apagar facilita merge conflicts se um dia quisermos puxar do upstream.
- **Quando:** 2026-10-30
- **Alternativas descartadas:** Fundir tudo num unico CLAUDE.md. Perde rastreabilidade do que e nosso e do que e deles.

### DT-003 — Nenhum uso do pipeline facial fora de laboratorio ate avaliacao LGPD
- **O que:** O fluxo rosto → PimEyes → dossie so roda com fotos de pessoas do time, com consentimento, em ambiente local. Nada de demo com terceiros, nada de deploy publico do backend com chaves reais.
- **Por que:** Biometria facial e dado pessoal sensivel (LGPD art. 5, II e art. 11). Montar dossie de terceiro sem base legal e risco juridico e reputacional direto pra InMinds. O projeto nasceu num hackathon nos EUA, onde o contexto regulatorio e outro.
- **Quando:** 2026-10-30
- **Alternativas descartadas:** Nenhuma. Isso nao e negociavel ate o BL-007 fechar.

---

## Decisoes de Negocio

### DN-001 — Objetivo do fork: estudo de referencia + base para enriquecimento B2B sem biometria
- **O que:** Dois objetivos encadeados. (1) Agora: estudar o padrao de agent swarm (Exa fast-pass + Browser Use em paralelo + sintese por LLM) e a UI em tempo real com Convex, para absorver como padrao InMinds. (2) Em seguida: usar o pipeline como base para um produto de enriquecimento B2B a partir de empresa/CNPJ, sem nenhum componente biometrico.
- **Por que:** O valor reaproveitavel esta no orquestrador de agentes e no padrao de UI, nao no reconhecimento facial. O facial e o pedaco mais caro, mais fragil e com risco LGPD (DT-003). Enriquecimento B2B tem demanda direta no pipeline comercial da InMinds.
- **Quando:** 2026-10-30. Decisao do Vitor.
- **Alternativas descartadas:** (c) demo comercial para InSecurity aproveitando `HumanDetection/`. Fica como ideia (FT-003), nao e objetivo do fork.
