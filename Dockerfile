FROM node:22-alpine AS builder
WORKDIR /app
RUN apk add --no-cache ca-certificates unzip
COPY package.json server.js setup.js ./
RUN node setup.js

FROM node:22-alpine
ENV NODE_ENV=production
ENV PORT=3000
WORKDIR /app
RUN apk upgrade --no-cache && apk add --no-cache ca-certificates
COPY --from=builder --chown=node:node /app ./
USER node
EXPOSE 3000
CMD ["node", "server.js"]