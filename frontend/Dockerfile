# Build stage
FROM node:lts-alpine AS build-stage
ARG PORT
WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Production stasge
FROM nginx:stable-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]