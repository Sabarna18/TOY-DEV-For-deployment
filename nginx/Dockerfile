# syntax=docker/dockerfile:1.7

####################################################
# Build React
####################################################

FROM node:22-alpine AS builder

LABEL org.opencontainers.image.title="Toy Dev Web"

WORKDIR /frontend

# Build-time API endpoint
ARG VITE_API_URL
ARG VITE_APP_VERSION


ENV VITE_API_URL=${VITE_API_URL}

COPY frontend/package*.json ./

RUN --mount=type=cache,target=/root/.npm \
    npm ci

COPY frontend .

RUN npm run build


####################################################
# Production Web Server
####################################################

FROM nginx:alpine

LABEL org.opencontainers.image.title="Toy Dev Web"
LABEL org.opencontainers.image.description="React + Nginx"
LABEL org.opencontainers.image.vendor="Sabarna Guha"

RUN apk update && \
    apk upgrade --no-cache && \
    rm -rf /var/cache/apk/*

COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=builder \
    /frontend/dist \
    /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]