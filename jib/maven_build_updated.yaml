#!/bin/bash

set -e

# Function to check for Git changes
check_git_changes() {
    API_NAME=$1
    echo "Checking for changes in $API_NAME"

    # Ensure the script is running from the correct base directory
    BASE_DIR="/c/Users/45239669/Documents/FDS/fds26_06/federated-content-search/root"

    if [ ! -d "$BASE_DIR" ]; then
        echo "Base directory $BASE_DIR does not exist. Exiting."
        exit 1
    fi

    cd "$BASE_DIR/$API_NAME"

    # Fetch latest changes and check for differences
    git fetch origin
    CHANGES=$(git diff origin/main --name-only)

    if [[ $CHANGES == *"$API_NAME"* ]]; then
        echo "Changes detected in $API_NAME"
        return 0
    else
        echo "No changes detected in $API_NAME"
        return 1
    fi
}

# Function for maven build
maven_build() {
    API_NAME=$1

    echo "Mvn Build started for $API_NAME"

    pwd

    # Ensure the script is running from the correct base directory
    BASE_DIR="/c/Users/45239669/Documents/FDS/fds26_06/federated-content-search/root"
    
    if [ ! -d "$BASE_DIR" ]; then
        echo "Base directory $BASE_DIR does not exist. Exiting."
        exit 1
    fi
    
    cd "$BASE_DIR"
    pwd

    export JAVA_HOME=/opt/java/zulu21.34.19-ca-jdk21.0.3-linux_x64
    export M2_HOME=/opt/maven/apache-maven-3.9.3
    export PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

    echo $JAVA_HOME
    echo $PATH
    echo $M2_HOME

    ls -lrta

    if [ ! -d "$API_NAME" ]; then
        echo "API directory $API_NAME does not exist. Exiting."
        exit 1
    fi

    cd "$API_NAME"
    ls -lrta

    mvn -version

    # Running these commands only once
    mvn clean compile install -Dimage.tag=v1.1
    mvn clean package -Dimage.tag=v1.1
}

# Function for docker build
docker_build() {
    API_NAME=$1

    echo "Docker Build started for $API_NAME"

    # Ensure the script is running from the correct base directory
    BASE_DIR="/c/Users/45239669/Documents/FDS/fds26_06/federated-content-search/root"
    
    cd "$BASE_DIR/$API_NAME"

    mvn clean package jib:dockerBuild -Dimage.tag=v1.1

    # Write the API name and image tag to the deploy_images.txt file
    echo "$API_NAME v1.1" >> /tmp/deploy_images.txt
}

# Stage: maven build-aggregate-api
stage_maven_build_aggregate_api() {
    if check_git_changes "aggregate-api"; then
        maven_build "aggregate-api"
        docker_build "aggregate-api"
    fi
}

# Stage: maven build-filenet-api
stage_maven_build_filenet_api() {
    if check_git_changes "filenet-api"; then
        maven_build "filenet-api"
        docker_build "filenet-api"
    fi
}

# Stage: maven build-arc-api
stage_maven_build_arc_api() {
    if check_git_changes "arc-api"; then
        maven_build "arc-api"
        docker_build "arc-api"
    fi
}

# Clear the deploy_images.txt file before starting
> /tmp/deploy_images.txt

# Execute stages
stage_maven_build_aggregate_api
stage_maven_build_filenet_api
stage_maven_build_arc_api

echo "All stages completed successfully."
