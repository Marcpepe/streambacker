# FROM node:0.12.7
FROM node:latest
LABEL version="0.0.1"
MAINTAINER Marc Perrin-Pelletier <marc.perrinpelletier@gmail.com>

RUN useradd -ms /bin/bash stbk
RUN cd && cp -R .bashrc .profile /home/stbk

# WORKDIR /var/www/streambacker
WORKDIR /home/stbk
# TODO Use .dockerignore file instead
COPY api api/
COPY client client/
COPY config config/
COPY devops devops/
COPY app.js \
     bower.json \
     package.json \
     .sailsrc \
     gulpfile.js \
     ./

RUN chown -R stbk:stbk /home/stbk
USER stbk

# TODO Evaluate --unsafe-perm security risk
# --unsafe-perm is needed otherwise postinstall fails
RUN npm install
# RUN npm install --unsafe-perm
CMD ./node_modules/.bin/sails lift
