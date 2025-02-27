FROM node:12-alpine as builder
WORKDIR /usr/src/app
COPY my-app/ ./my-app/
RUN cd my-app && npm install @angular/cli && npm install && npm run build

FROM node:12-alpine AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/my-app/dist ./my-app/dist
COPY package*.json ./
RUN npm install
RUN npm run start
COPY server.js .

CMD ["node", "server.js"]
