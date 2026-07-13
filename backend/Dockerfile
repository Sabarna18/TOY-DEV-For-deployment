FROM python:3.13-slim

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN pip install uv

RUN uv sync --frozen --no-dev

COPY . .

EXPOSE 8003

ENTRYPOINT ["./docker-entrypoint.sh"]