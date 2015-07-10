FROM node:0.10
ADD . /code
WORKDIR /code
CMD coffee server/server.coffee
