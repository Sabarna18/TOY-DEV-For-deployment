#!/bin/sh

set -e

echo "===================================="
echo "Toy Deployment App"
echo "Starting container..."
echo "===================================="

echo ""
echo "Running Alembic migrations..."

uv run alembic upgrade head

echo ""
echo "Database is up to date."

echo ""
echo "Starting FastAPI..."

exec uv run uvicorn \
    src.app:app \
    --host 0.0.0.0 \
    --port 8003