# Stage 1: Build Application
FROM maven:3.8.5-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy files and build
COPY src/pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Minimal Runtime Image
FROM eclipse-temurin:21-jre

# Set working directory
WORKDIR /app

# Copy only the built JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]

