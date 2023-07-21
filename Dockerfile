FROM node:lts-alpine as builder
COPY . .
RUN npm install -g npm@7.20.2
RUN npm install --only=prod
RUN npm run build

FROM node:lts-alpine
WORKDIR /var/www/app
RUN apk add bash
COPY --from=builder ./.npmrc ./.npmrc
COPY --from=builder ./server ./server
COPY --from=builder ./build ./build

RUN npm install -g @babel/cli @babel/core @babel/preset-env
x
RUN rm -f .npmrc

CMD ["node", "server/server.js"]
