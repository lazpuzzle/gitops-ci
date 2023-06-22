# Build Stage
FROM node:14-alpine as build-step

WORKDIR /app

COPY package.json /app/

RUN npm install

COPY . /app

RUN npm run build

# NGINX Stage
FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build-step /app/build ./

CMD ["nginx", "-g", "daemon off;"]

