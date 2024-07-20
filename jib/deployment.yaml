#!/bin/bash

set -e

# Google Cloud project details
PROJECT_ID="your-gcp-project-id"
CLUSTER_NAME="your-cluster-name"
CLUSTER_ZONE="your-cluster-zone"
NAMESPACE="your-kubernetes-namespace"

# Authenticate to GCP and get GKE credentials
gcloud auth activate-service-account --key-file /path/to/your-service-account-key.json
gcloud config set project $PROJECT_ID
gcloud container clusters get-credentials $CLUSTER_NAME --zone $CLUSTER_ZONE --project $PROJECT_ID

# Function to update Kubernetes deployment
update_k8s_deployment() {
    API_NAME=$1
    IMAGE_TAG=$2
    CONTAINER_REGISTRY="gcr.io/$PROJECT_ID"

    echo "Updating Kubernetes deployment for $API_NAME to use image tag $IMAGE_TAG"

    kubectl set image deployment/$API_NAME $API_NAME=$CONTAINER_REGISTRY/$API_NAME:$IMAGE_TAG -n $NAMESPACE
}

# Read the image tags from the file
if [ -f /tmp/deploy_images.txt ]; then
    while read line; do
        API_NAME=$(echo $line | cut -d' ' -f1)
        IMAGE_TAG=$(echo $line | cut -d' ' -f2)
        update_k8s_deployment $API_NAME $IMAGE_TAG
    done < /tmp/deploy_images.txt
else
    echo "No image tags found to deploy."
fi

echo "GKE deployment completed successfully."

