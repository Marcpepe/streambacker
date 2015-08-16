FROM node:0.12
LABEL version="0.1"
MAINTAINER Marc Perrin-Pelletier <marc.perrinpelletier@gmail.com>
WORKDIR /var/www/streambacker
COPY client \
     common \
     server \
     package.json \
     bower.json \
     gulpfile.js \
     /var/www/streambacker/
RUN cd /var/www/streambacker; \
    npm install
CMD ./node_modules/.bin/coffee server/server.coffee
