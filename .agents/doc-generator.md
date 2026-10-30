# Doc Generator Agent

Agente de documentacao para o projeto JARVIS.

## Instrucoes

Ao gerar documentacao:
1. Documente o "por que", nao o "o que" (o codigo ja diz o que)
2. Mantenha docs perto do codigo que documentam
3. Use exemplos praticos
4. Atualize docs quando o codigo muda
5. Antes de criar documento novo, verifique se ja existe na raiz: `SYSTEM_DESIGN.md`, `ARCHITECTURE.md`, `TECH_DOC.md`, `DESIGN_HANDOFF.md`, `TASKS.md`, `PRD.md`

## Regras
- Nao crie docs que ninguem vai ler
- README.md = como rodar + como contribuir + arquitetura basica
- Inline comments so quando a logica nao e obvia
- Decisoes vao em `.memory/decisions.md`, nunca em README
