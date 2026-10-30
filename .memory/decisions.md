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

### DT-003 — Pipeline completo liberado em laboratorio isolado. Restricoes valem para produto e cliente
- **O que:** Em laboratorio (DT-004) o pipeline roda inteiro, sem restricao: facial, PimEyes, criacao autonoma de contas, dark web. Fora do laboratorio, ou seja, em qualquer uso com cliente, demo publica ou produto, nada disso entra sem a avaliacao LGPD (BL-007) e sem remover os modulos que violam termos de uso de plataformas (EF-001.1).
- **Por que:** O Vitor decidiu em 2026-10-30 que o objetivo agora e aprender o maximo do que o projeto faz, e isso exige rodar tudo. O Claudin registrou a ressalva: biometria facial e dado sensivel (LGPD art. 5 II e art. 11), e o modulo `agents/account_manager.py` cria contas falsas em LinkedIn, X, Instagram e outros com emails descartaveis, o que viola termos de uso e gera passivo. O risco fica contido pelo isolamento do ambiente (DT-004), nao pela restricao de uso.
- **Quando:** 2026-10-30 (revisada no mesmo dia; versao original restringia o facial a fotos do time)
- **Alternativas descartadas:** Manter a restricao original. Impediria entender o pipeline de identificacao, que e metade do codigo.

### DT-004 — Laboratorio roda em ambiente isolado, nunca em maquina pessoal nem na VPS de producao
- **O que:** O JARVIS so roda numa VM dedicada de laboratorio, separada da `vm-inminds-hub-prd` (Coolify, `panel.inminds.com.br`) e de qualquer PC com dados pessoais. VM pode ser desligada quando nao estiver em uso. Chaves de API do lab sao chaves proprias do lab, nunca as de producao.
- **Por que:** O Vitor apontou que o PC atual tem muita coisa pessoal. O Claudin acrescentou: o lab cria contas falsas, abre browsers automatizados em dezenas de sites e baixa modelos de visao. Isso nao pode compartilhar host, rede nem credenciais com Supabase, n8n e Evolution API de producao.
- **Quando:** 2026-10-30
- **Alternativas descartadas:** (a) Rodar no PC do Vitor: descartado por ele. (b) Rodar na VPS de producao via Coolify: mistura risco de lab com o que paga as contas. (c) GitHub Codespaces: sem persistencia barata e com limite de horas; serve de fallback se a VM demorar.

### DT-005 — Fontes brasileiras como padrao, internacionais sob decisao do operador
- **O que:** A lista de fontes dos agentes e reescrita para o Brasil: Receita Federal (CNPJ, QSA), Jusbrasil, Diarios Oficiais, Reclame Aqui, Google Noticias BR, LinkedIn BR, site da empresa. As fontes do projeto original (X, Instagram, TikTok, Reddit, GitHub, dark web) ficam disponiveis, mas desligadas por padrao, e o operador liga por consulta.
- **Por que:** O projeto original e todo EUA. Para prospeccao B2B no Brasil, Receita e Jusbrasil valem mais que Instagram. Decisao do Vitor em 2026-10-30.
- **Quando:** 2026-10-30
- **Alternativas descartadas:** Manter as fontes originais e so acrescentar as brasileiras. Gasta browser pago em fonte que nao gera valor.

---

## Decisoes de Negocio

### DN-001 — Objetivo do fork: estudo de referencia + base para enriquecimento B2B sem biometria
- **O que:** Dois objetivos encadeados. (1) Agora: estudar o padrao de agent swarm (Exa fast-pass + Browser Use em paralelo + sintese por LLM) e a UI em tempo real com Convex, para absorver como padrao InMinds. (2) Em seguida: usar o pipeline como base para um produto de enriquecimento B2B a partir de empresa/CNPJ, sem nenhum componente biometrico.
- **Por que:** O valor reaproveitavel esta no orquestrador de agentes e no padrao de UI, nao no reconhecimento facial. O facial e o pedaco mais caro, mais fragil e com risco LGPD (DT-003). Enriquecimento B2B tem demanda direta no pipeline comercial da InMinds.
- **Quando:** 2026-10-30. Decisao do Vitor.
- **Alternativas descartadas:** (c) demo comercial para InSecurity aproveitando `HumanDetection/`. Fica como ideia (FT-003), nao e objetivo do fork.

### DN-002 — Primeiro usuario e a propria InMinds, com abertura para virar oferta a clientes
- **O que:** A Fase 2 e construida para o time comercial da InMinds usar em prospeccao. A arquitetura nao pode impedir que vire produto para cliente depois, mas nenhuma decisao de agora e tomada em funcao disso.
- **Por que:** Validar com uso proprio antes de vender. Decisao do Vitor em 2026-10-30.
- **Quando:** 2026-10-30
