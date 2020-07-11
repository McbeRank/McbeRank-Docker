# BUILD (McbeRank-Vue)
FROM node:latest

RUN mkdir -p /usr/src/build

WORKDIR /usr/src/build

COPY McbeRank-Vue/package*.json ./

RUN npm install

COPY McbeRank-Vue/ ./

RUN npm run build

# PRODUCTION (McbeRank)
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY McbeRank/package*.json ./

RUN npm install

COPY McbeRank/ ./

RUN cp -r /usr/src/build/dist/ ./public/

EXPOSE 3500

CMD ["npm", "run", "start"]
