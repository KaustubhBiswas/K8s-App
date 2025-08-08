#!/bin/bash
set -e

# Variables
DOCKER_USERNAME="kaustubhbiswas"
TAG=$(curl -s https://hub.docker.com/v2/repositories/$DOCKER_USERNAME/node-app/tags/ \
      | jq -r '.results[0].name')

# Deploy to local Minikube
kubectl set image deployment/node-app node-app=$DOCKER_USERNAME/node-app:$TAG
kubectl rollout status deployment/node-app
