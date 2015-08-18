# FROM node:0.12.7
FROM node:latest
LABEL version="0.0.1"
MAINTAINER Marc Perrin-Pelletier <marc.perrinpelletier@gmail.com>

RUN useradd -ms /bin/bash stbk
RUN cd && cp -R .bashrc .profile /home/stbk

# WORKDIR /var/www/streambacker
WORKDIR /home/stbk
# TODO Use .dockerignore file instead
COPY client client/
COPY common common/
COPY devops devops/
COPY server server/
COPY package.json \
     bower.json \
     gulpfile.js \
     ./

RUN chown -R stbk:stbk /home/stbk
USER stbk

# TODO Evaluate --unsafe-perm security risk
# --unsafe-perm is needed otherwise postinstall fails
RUN npm install
# RUN npm install --unsafe-perm
CMD ./node_modules/.bin/coffee server/server.coffee
