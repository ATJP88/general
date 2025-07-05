FROM openjdk:8-slim as builder

WORKDIR /app

COPY ["build.gradle", "gradlew", "./"]
COPY gradle gradle
RUN chmod +x gradlew && ./gradlew downloadRepos

COPY . .
RUN chmod +x gradlew && ./gradlew installDist

# Download Stackdriver Profiler Java agent and grpc_health_probe
RUN apt-get -y update && apt-get install -y --no-install-recommends wget && \
    mkdir -p /opt/cprof && \
    wget -q -O- https://storage.googleapis.com/cloud-profiler/java/latest/profiler_java_agent.tar.gz | tar xz -C /opt/cprof && \
    GRPC_HEALTH_PROBE_VERSION=v0.2.1 && \
    wget -qO/app/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /app/grpc_health_probe && \
    apt-get purge -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

FROM gcr.io/distroless/java:8

WORKDIR /app
COPY --from=builder /app /app
COPY --from=builder /opt/cprof /opt/cprof

EXPOSE 9555
ENTRYPOINT [\"/app/build/install/hipstershop/bin/AdService\"]