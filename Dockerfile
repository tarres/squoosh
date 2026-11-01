# syntax=docker/dockerfile:1
FROM node:24.22.2 AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/build/ /usr/share/nginx/html/
EXPOSE 80
