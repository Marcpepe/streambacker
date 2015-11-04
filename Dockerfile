FROM node:latest
LABEL version="0.0.1"
MAINTAINER Marc Perrin-Pelletier <marc.perrinpelletier@gmail.com>

WORKDIR /var/www/stbk

RUN useradd -ms /bin/bash stbk

RUN chown -R stbk:stbk /var/www
USER stbk

COPY package.json \
     bower.json \
     gulpfile.js \
     ./
COPY client client/
COPY devops/build devops/build/
RUN npm install

COPY api api/
COPY config config/
COPY app.coffee \
     .sailsrc \
     ./

VOLUME /var/www/stbk

CMD ./node_modules/.bin/sails lift
