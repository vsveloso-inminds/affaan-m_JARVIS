FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    PATH="/app/.venv/bin:$PATH"

# ffmpeg: extracao de frames de video (capture/frame_extractor.py)
# libgl1 + libglib2.0-0: exigidos pelo opencv que o mediapipe traz embutido
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg libgl1 libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir "uv>=0.5,<1"

WORKDIR /app

# Instala dependencias a partir do uv.lock (mesmo caminho do CI). Em camada
# separada para o cache sobreviver a mudancas de codigo.
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --no-install-project

COPY . .
RUN uv sync --frozen --no-dev

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
