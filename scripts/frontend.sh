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

#########################################################
# Environment Information
#########################################################

echo ""
echo "[0/7] Environment"

echo "Working Directory:"
pwd

echo ""
echo "Node Version:"
node --version

echo ""
echo "NPM Version:"
npm --version

echo ""
echo "NODE_ENV=${NODE_ENV:-<not set>}"

echo ""
echo "NPM omit:"
npm config get omit || true

echo ""
echo "Package Manager Config:"
npm config list

#########################################################
# Package Verification
#########################################################

echo ""
echo "[1/7] Verify package.json"

cat package.json

#########################################################
# Install Dependencies
#########################################################

echo ""
echo "[2/7] Installing Dependencies"

# Force installation of devDependencies even if NODE_ENV=production
npm ci --include=dev

#########################################################
# Verify Installation
#########################################################

echo ""
echo "[3/7] Installed Packages"

npm ls --depth=0 || true

echo ""
echo "Checking ESLint..."

if [ -f node_modules/.bin/eslint ]; then
    echo "✓ ESLint installed"
else
    echo "✗ ESLint NOT installed"
    exit 1
fi

#########################################################
# ESLint
#########################################################

echo ""
echo "[4/7] ESLint"

if npm run | grep -q "lint"; then
    npm run lint
else
    echo "No lint script found."
fi

#########################################################
# Tests
#########################################################

echo ""
echo "[5/7] Frontend Tests"

if npm run | grep -q "test"; then
    npm test
else
    echo "No test script found."
fi

#########################################################
# Production Build
#########################################################

echo ""
echo "[6/7] Production Build"

npm run build

#########################################################
# Finish
#########################################################

echo ""
echo "[7/7] Frontend Verification Complete"

echo ""
echo "========================================="
echo " Frontend Pipeline Passed"
echo "========================================="