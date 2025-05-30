# Etapa 1: Construir el sitio Quartz
FROM node:22 AS builder 
WORKDIR /usr/src/app

# Copiar archivos de definición de proyecto y dependencias
COPY package.json .
COPY package-lock.json* .

# Instalar dependencias del proyecto
RUN npm ci

# Copiar el resto del código fuente de tu proyecto Quartz
COPY . .

# Construir el sitio Quartz usando el comando directo de npx
RUN npx quartz build

RUN echo "==== Contenido de /usr/src/app/public después de la construcción de Quartz: ===="
RUN ls -R /usr/src/app/public
RUN echo "=============================================================================="
# Etapa 2: Servir el sitio estático con Nginx
FROM nginx:alpine

# Copiar los archivos estáticos construidos desde la etapa 'builder'
COPY --from=builder /usr/src/app/public /usr/share/nginx/html

# Exponer el puerto 80.
EXPOSE 80
