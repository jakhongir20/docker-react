FROM node:16-alpine as builder
RUN apt-get update && apt-get install -y nodejs 

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build  /usr/share/nginx/html

CMD npm run test -- --coverage

