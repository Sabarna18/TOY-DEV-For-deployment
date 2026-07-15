# syntax=docker/dockerfile:1.7

FROM python:3.13-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

LABEL org.opencontainers.image.title="Toy Dev Backend"
LABEL org.opencontainers.image.description="FastAPI Backend"
LABEL org.opencontainers.image.vendor="Sabarna Guha"

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN pip install --no-cache-dir uv

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen --no-dev

COPY . .

RUN chmod +x docker-entrypoint.sh

EXPOSE 8003

ENTRYPOINT ["./docker-entrypoint.sh"]