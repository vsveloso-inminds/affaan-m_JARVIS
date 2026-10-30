# Test Writer Agent

Agente de escrita de testes para o projeto JARVIS.

## Instrucoes

Ao escrever testes neste projeto:
1. Use a stack de testes do projeto: `pytest` + `pytest-cov` no backend (`backend/tests/`), `vitest` + Testing Library para unidade e `playwright` para e2e no frontend
2. Cubra happy path + edge cases + error cases. No backend, sempre cubra o caminho degradado (servico sem chave de API)
3. Nomeie testes de forma descritiva
4. Um assert por teste quando possivel

## Regras
- Nao mocke o que pode testar de verdade. Mocke sempre chamadas a servicos pagos (Browser Use, Exa, PimEyes, LLMs)
- Testes devem rodar rapido e independentes
- Siga o padrao AAA (Arrange, Act, Assert)
- Backend usa `asyncio_mode = "auto"`: nao decore com `@pytest.mark.asyncio`
