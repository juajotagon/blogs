# Etapa 1: Construir el sitio Quartz
FROM node:20-alpine AS builder # O node:22-alpine si lo prefieres
WORKDIR /app
RUN apk add --no-cache git
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/public /usr/share/nginx/html
EXPOSE 80
