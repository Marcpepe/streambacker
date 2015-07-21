FROM node:0.12
MAINTAINER Marc Perrin-Pelletier <marc.perrinpelletier@gmail.com>
ADD . /app
WORKDIR /app
RUN npm install
CMD ./node_modules/.bin/coffee server/server.coffee
