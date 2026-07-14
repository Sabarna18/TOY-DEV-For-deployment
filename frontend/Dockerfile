# ==================================================
# React Builder Image
# Used only for development/testing
# Production build happens in nginx/Dockerfile
# ==================================================

FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

CMD ["npm","run","dev","--","--host","0.0.0.0"]