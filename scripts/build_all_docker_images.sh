#!/bin/bash
# Script to build all Docker images for each service in the project
# Usage: bash build_all_docker_images.sh

set -e

# List of service directories containing Dockerfile
services=(
  "adservice"
  "cartservice"
  "checkoutservice"
  "currencyservice"
  "emailservice"
  "frontend"
  "loadgenerator"
  "paymentservice"
  "productcatalogservice"
  "recommendationservice"
  "shippingservice"
)

for service in "${services[@]}"; do
  if [ -f "../$service/Dockerfile" ]; then
    echo "\nBuilding Docker image for $service..."
    docker build -t "$service:local" "../$service"
  else
    echo "\nNo Dockerfile found for $service, skipping."
  fi
done

echo "\nAll Docker images built."
