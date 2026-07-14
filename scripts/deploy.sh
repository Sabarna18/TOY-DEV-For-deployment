#!/usr/bin/env bash

# ==========================================================
# Production Deployment Script
# ==========================================================

set -Eeuo pipefail

echo "========================================="
echo " Production Deployment"
echo "========================================="

echo ""
echo "Stopping existing containers..."

docker compose down

echo ""
echo "Pulling latest images..."

docker compose pull

echo ""
echo "Starting application..."

docker compose up -d

echo ""
echo "Deployment complete."

docker compose ps

echo ""
echo "✓ Deployment successful"