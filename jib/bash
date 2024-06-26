#!/bin/bash

set -e

# Function for maven build
maven_build() {
    API_NAME=$1

    echo "Mvn Build started for $API_NAME"

    pwd
    cd root
    pwd

    export JAVA_HOME=/opt/java/zulu21.34.19-ca-jdk21.0.3-linux_x64
    export M2_HOME=/opt/maven/apache-maven-3.9.3

    echo $JAVA_HOME
    echo $PATH
    echo $M2_HOME

    ls -lrta

    cd $API_NAME

    ls -lrta

    mvn -version
    mvn clean compile -Dimage.tag=v1.1
    mvn clean package -Dimage.tag=v1.1
    mvn clean package jib:dockerBuild -Dimage.tag=v1.1
}

# Stage: maven build-aggregate-api
stage_maven_build_aggregate_api() {
    maven_build "aggregate-api"
}

# Stage: maven build-filenet-api
stage_maven_build_filenet_api() {
    maven_build "filenet-api"
}

# Stage: maven build-arc-api
stage_maven_build_arc_api() {
    maven_build "arc-api"
}

# Execute stages
stage_maven_build_aggregate_api
stage_maven_build_filenet_api
stage_maven_build_arc_api

echo "All stages completed successfully."
