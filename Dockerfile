# Etapa 1: Construir el sitio Quartz
FROM node:22-alpine AS builder
WORKDIR /app
RUN apk add --no-cache git
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
RUN npx quartz build

FROM nginx:alpine
COPY --from=builder /usr/src/app/public /usr/share/nginx/html
EXPOSE 80
