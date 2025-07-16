#!/bin/bash
# Ensure multiarch builder exists and is used
docker buildx use multiarch-builder || docker buildx create --name multiarch-builder --driver docker-container --use
docker buildx inspect --bootstrap

docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.backend -t guestros/localgpt-backend:latest . --push
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.frontend -t guestros/localgpt-frontend:latest . --push
docker buildx build --platform linux/amd64,linux/arm64 -f Dockerfile.rag-api -t guestros/localgpt-rag-api:latest . --push
