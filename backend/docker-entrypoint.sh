#!/usr/bin/env sh

set -eu

echo ""
echo "==============================================="
echo " Toy Deployment Backend"
echo "==============================================="
echo ""

echo "[1/4] Checking environment..."

if [ -z "${DATABASE_URL:-}" ]; then
    echo "DATABASE_URL is not configured."
    exit 1
fi

echo "✓ Environment OK"

echo ""
echo "[2/4] Running Alembic migrations..."

uv run alembic upgrade head

echo "✓ Database schema is up to date"

echo ""
echo "[3/4] Starting FastAPI..."

echo ""
echo "==============================================="
echo " FastAPI Starting"
echo "==============================================="
echo ""

exec uv run uvicorn \
    src.app:app \
    --host 0.0.0.0 \
    --port 8003 \
    --proxy-headers