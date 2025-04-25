# Use an official Maven image to build the application
FROM maven:3.8.1-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean install

# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/java-helloworld-app.jar /app/java-helloworld-app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "java-helloworld-app.jar"]
