#!/bin/bash
# Script to deploy all Kubernetes YAML files in the k8s directory
# Usage: bash deploy_all_k8s.sh

set -e

K8S_DIR="../k8s"

if [ ! -d "$K8S_DIR" ]; then
  echo "Kubernetes directory $K8S_DIR does not exist."
  exit 1
fi

# Upgrade Gradle wrapper for adservice to support Java 11+
if [ -d "../adservice" ]; then
  echo "Upgrading Gradle wrapper in adservice to 6.9..."
  cd ../adservice
  ./gradlew wrapper --gradle-version 6.9 || echo "Gradle wrapper upgrade failed, please check manually."
  cd -
fi

# Apply YAMLs in the k8s directory
for yaml in "$K8S_DIR"/*.yaml; do
  if [ -f "$yaml" ]; then
    echo "Applying $yaml ..."
    kubectl apply -f "$yaml"
  fi
done

# Also apply YAMLs in subdirectories (e.g., wsl2)
for dir in "$K8S_DIR"/*/; do
  if [ -d "$dir" ]; then
    for yaml in "$dir"*.yaml; do
      if [ -f "$yaml" ]; then
        echo "Applying $yaml ..."
        kubectl apply -f "$yaml"
      fi
    done
  fi
done

echo "All Kubernetes resources applied."
