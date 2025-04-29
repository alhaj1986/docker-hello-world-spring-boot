# Use an official Maven image to build the application
FROM maven:3.8.1 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Use Amazon Corretto 17 runtime as a parent image
FROM amazoncorretto:17 AS runtime
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

# Use an official Trivy image to scan the Docker image
FROM aquasec/trivy:latest AS trivy
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
