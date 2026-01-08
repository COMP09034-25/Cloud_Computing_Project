# Stage 1: Build the application
FROM gradle:8.5-jdk21 AS builder
WORKDIR /app

# Copy only build files first for better caching
COPY build.gradle settings.gradle ./
COPY gradle ./gradle
COPY gradlew ./
RUN chmod +x gradlew || true

# Copy source last
COPY src ./src

# Build boot jar
RUN gradle bootJar --no-daemon

# Stage 2: Runtime image
FROM eclipse-temurin:21-jre

# Create non-root user
RUN useradd -m spring
USER spring

WORKDIR /workspace
COPY --from=builder /app/build/libs/*.jar /workspace/app.jar

# Beanstalk routing expects a known container port
EXPOSE 9001

# Optional: safer JVM defaults for containers
ENTRYPOINT ["java","-XX:+UseContainerSupport","-jar","/workspace/app.jar"]
