#!/usr/bin/env bash

# ==========================================================
# Docker Validation Script
# Used by GitHub Actions and local development
# ==========================================================

set -Eeuo pipefail

echo "========================================="
echo " Docker Validation Pipeline"
echo "========================================="

echo ""
echo "[1/5] Checking Docker installation..."

docker --version
docker compose version
docker buildx version

echo ""
echo "[2/5] Validating compose.yaml..."

docker compose config >/dev/null

echo "✓ compose.yaml is valid"

echo ""
echo "[3/5] Verifying required Dockerfiles..."

required_files=(
    "backend/Dockerfile"
    "nginx/Dockerfile"
    "compose.yaml"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "✗ Missing required file: $file"
        exit 1
    fi
done

echo "✓ Required Dockerfiles found"

echo ""
echo "[4/5] Verifying BuildKit support..."

if docker buildx version >/dev/null 2>&1; then
    echo "✓ Docker Buildx available"
else
    echo "✗ Docker Buildx is not available"
    exit 1
fi

echo ""
echo "[5/5] Docker validation complete"

echo ""
echo "========================================="
echo " Docker Validation Passed"
echo "========================================="