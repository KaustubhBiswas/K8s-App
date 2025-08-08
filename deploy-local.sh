#!/bin/bash
set -e

DOCKER_USERNAME="kaustubhbiswas"

echo "Fetching latest commit SHA from Docker Hub..."
TAG=$(curl -s https://hub.docker.com/v2/repositories/$DOCKER_USERNAME/node-app/tags/ \
  | grep -o '"name":"[a-f0-9]\{40\}"' \
  | head -n 1 \
  | cut -d':' -f2 \
  | tr -d '"')

if [ -z "$TAG" ]; then
  echo "❌ Could not fetch latest tag from Docker Hub!"
  exit 1
fi

echo "Latest tag is: $TAG"
echo "Deploying to local Minikube..."

kubectl set image deployment/node-app node-app=$DOCKER_USERNAME/node-app:$TAG
kubectl rollout status deployment/node-app
