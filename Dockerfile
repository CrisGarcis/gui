FROM node:14-alpine AS builder

ENV NODE_VERSION 14.19.1
WORKDIR /app
COPY ./ /app

ENV NODE_OPTIONS=--max_old_space_size=8192
RUN npm install 
RUN npm run build

FROM nginx:1.15
COPY --from=builder /app/build/ /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf