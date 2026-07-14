# Toy Dev – Production Deployment Learning Project

A production-oriented full-stack application built to learn modern software engineering, containerization, CI/CD, cloud deployment, and DevOps practices.

This project is intentionally designed to simulate the workflow followed by engineering teams when building and deploying cloud-native applications.

---

# Project Objectives

* Build a production-ready FastAPI backend.
* Develop a React frontend using Vite.
* Containerize every service using Docker.
* Configure Nginx as a reverse proxy and static web server.
* Implement a modern Git workflow.
* Build a reusable GitHub Actions CI/CD pipeline.
* Publish Docker images to GitHub Container Registry (GHCR).
* Deploy to cloud platforms such as Railway while remaining platform-independent.

---

# Technology Stack

## Backend

* FastAPI
* SQLAlchemy
* Alembic
* PostgreSQL
* Pydantic Settings
* Uvicorn
* uv Package Manager

## Frontend

* React 19
* Vite
* ESLint

## Infrastructure

* Docker
* Docker Compose
* Nginx
* GitHub Actions
* GitHub Container Registry (GHCR)

---

# Architecture

```
                    Browser
                        │
                        ▼
                Nginx (toy-web)
          Static Files + Reverse Proxy
                        │
        ┌───────────────┴───────────────┐
        │                               │
        ▼                               ▼
 React Production Build           FastAPI Backend
                                        │
                                        ▼
                                  PostgreSQL
```

---

# Repository Structure

```
Toy-dev
│
├── backend/
│   ├── alembic/
│   ├── src/
│   ├── Dockerfile
│   ├── docker-entrypoint.sh
│   └── pyproject.toml
│
├── frontend/
│   ├── src/
│   ├── public/
│   └── package.json
│
├── nginx/
│   ├── Dockerfile
│   └── nginx.conf
│
├── scripts/
│   ├── backend.sh
│   ├── frontend.sh
│   ├── docker.sh
│   └── deploy.sh
│
├── .github/
│   └── workflows/
│
├── compose.yaml
└── README.md
```

---

# Development Workflow

Feature development follows Git Flow.

```
main
│
develop
│
feature/*
```

### Branches

* **main** → Stable production-ready code
* **develop** → Integration branch
* **feature/*** → Feature development

---

# Local Development

Clone the repository.

```
git clone <repository-url>
```

Start the complete application.

```
docker compose up --build
```

Open

```
http://localhost
```

The API is available at

```
http://localhost/api/v1
```

Swagger UI

```
http://localhost/docs
```

---

# Docker Architecture

The application consists of three containers.

## PostgreSQL

Stores application data.

## Backend

Runs the FastAPI application.

Responsibilities

* API
* Business Logic
* Alembic Migrations

## Web

Contains

* Nginx
* React Production Build

Responsibilities

* Serve React
* Reverse proxy `/api`
* Handle static assets

---

# CI Pipeline

Every push and pull request triggers the Continuous Integration workflow.

Pipeline

```
Checkout

↓

Backend Verification

↓

Frontend Verification

↓

Docker Validation

↓

Docker Build

↓

Summary
```

Backend verification includes

* Dependency installation
* Import verification
* Ruff
* Black
* MyPy
* Pytest

Frontend verification includes

* npm install
* ESLint
* Production Build

Docker verification includes

* Docker validation
* BuildKit verification
* Compose validation

---

# Docker Pipeline

The Docker workflow

* Builds backend image
* Builds web image
* Uses BuildKit cache
* Generates SBOM
* Generates Provenance
* Publishes to GHCR

Published Images

```
ghcr.io/<owner>/toy-dev-backend

ghcr.io/<owner>/toy-dev-web
```

---

# Environment Variables

Backend

```
DATABASE_URL=

APP_NAME=

ENVIRONMENT=

CORS_ORIGINS=
```

Frontend

```
VITE_API_URL=/api/v1
```

---

# Docker Compose

```
docker compose up --build
```

Stop

```
docker compose down
```

View logs

```
docker compose logs -f
```

---

# GitHub Actions

Current Workflows

* Continuous Integration
* Docker Pipeline

Upcoming

* Release Pipeline
* Security Pipeline
* Cloud Deployment Pipeline

---

# Code Quality

Backend

* Ruff
* Black
* MyPy
* Pytest

Frontend

* ESLint
* Production Build Validation

---

# Container Features

* Multi-stage Docker builds
* BuildKit cache mounts
* Health checks
* OCI image labels
* Build provenance
* Software Bill of Materials (SBOM)

---

# Cloud Deployment Roadmap

Current

```
Local Docker
```

Next

```
GitHub Actions

↓

GitHub Container Registry

↓

Railway
```

Future

```
Render

Fly.io

DigitalOcean

AWS

Azure

Google Cloud

Kubernetes
```

The deployment architecture is intentionally platform-independent.

---

# Future Enhancements

* GitHub Releases
* Automated semantic versioning
* Security scanning
* Dependabot
* HTTPS
* Monitoring
* Prometheus
* Grafana
* Loki
* OpenTelemetry
* Redis
* Background workers
* Kubernetes deployment

---

# Learning Objectives

This repository demonstrates practical experience with

* FastAPI
* React
* PostgreSQL
* Docker
* Docker Compose
* Nginx
* Git Flow
* CI/CD
* GitHub Actions
* GitHub Container Registry
* Cloud Deployment
* DevOps Practices

---

# License

This repository is intended for educational purposes and production deployment practice.

---

## Author

**Sabarna Guha**

B.Tech Computer Science

Production Deployment Learning Project

Built to explore modern backend engineering, cloud-native deployment, and DevOps workflows.
