#!/usr/bin/env bash

# ==========================================================
# Frontend CI Pipeline
# React + Vite
# ==========================================================

set -Eeuo pipefail

echo "========================================="
echo " Frontend CI Pipeline"
echo "========================================="

cd frontend

echo ""
echo "[1/6] Node Environment"

node --version
npm --version

echo ""
echo "[2/6] Installing Dependencies"

npm ci

echo ""
echo "[3/6] ESLint"

if npm run | grep -q "lint"; then
    npm run lint
else
    echo "No lint script found. Skipping."
fi

echo ""
echo "[4/6] Frontend Tests"

if npm run | grep -q "test"; then
    npm test
else
    echo "No test script found. Skipping."
fi

echo ""
echo "[5/6] Production Build"

npm run build

echo ""
echo "[6/6] Frontend Verification Complete"

echo ""
echo "========================================="
echo " Frontend Pipeline Passed"
echo "========================================="