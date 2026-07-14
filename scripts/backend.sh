#!/usr/bin/env bash

# ==========================================================
# Backend CI Pipeline
# ==========================================================

set -Eeuo pipefail

echo "========================================="
echo " Backend CI Pipeline"
echo "========================================="

cd backend

echo ""
echo "[1/8] Python Version"

python --version

echo ""
echo "[2/8] Installing uv"

python -m pip install --upgrade pip
python -m pip install uv

echo ""
echo "[3/8] Installing dependencies"

uv sync --frozen --all-groups

echo ""
echo "[4/8] Import Verification"

uv run python -c "
import src.app
print('✓ FastAPI imports successfully')
"

echo ""
echo "[5/8] Ruff"

if uv run ruff --version >/dev/null 2>&1; then
    uv run ruff check .
else
    echo "Ruff not installed. Skipping."
fi

echo ""
echo "[6/8] Black"

if uv run black --version >/dev/null 2>&1; then
    uv run black --check .
else
    echo "Black not installed. Skipping."
fi

echo ""
echo "[7/8] MyPy"

if uv run mypy --version >/dev/null 2>&1; then
    uv run mypy .
else
    echo "MyPy not installed. Skipping."
fi

echo ""
echo "[8/8] Pytest"

if [ -d tests ]; then
    uv run pytest -v
else
    echo "No tests directory found. Skipping."
fi

echo ""
echo "========================================="
echo " Backend Pipeline Passed"
echo "========================================="