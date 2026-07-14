# syntax=docker/dockerfile:1.7

####################################################
# Build React
####################################################

FROM node:22-alpine AS builder

LABEL org.opencontainers.image.title="Toy Dev Web"

WORKDIR /frontend

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

COPY nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=builder \
    /frontend/dist \
    /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g","daemon off;"]