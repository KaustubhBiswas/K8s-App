#!/bin/bash
set -e

DOCKER_USER="kaustubhbiswas"   # change to your Docker Hub username

echo "Fetching latest commit SHA from GitHub..."
COMMIT_SHA=$(git rev-parse HEAD)

echo "Updating Kubernetes deployment to use image: $DOCKER_USER/node-app:$COMMIT_SHA"
kubectl set image deployment/node-app node-app=$DOCKER_USER/node-app:$COMMIT_SHA

echo "Waiting for rollout..."
kubectl rollout status deployment/node-app

echo "Deployment updated successfully!"
kubectl get pods -o wide
