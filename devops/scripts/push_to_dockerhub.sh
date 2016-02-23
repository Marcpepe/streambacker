#!/bin/bash
set -e

ls ~/docker
if [[ -e ~/docker/image.tar ]]; then docker load -i ~/docker/image.tar; fi
docker build -t marcpepe/streambacker-server:latest .
mkdir -p ~/docker; docker save marcpepe/streambacker-server  > ~/docker/image.tar
docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker push marcpepe/streambacker-server
