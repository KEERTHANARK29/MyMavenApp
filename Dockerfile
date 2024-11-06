# Use an official Maven image as a parent image
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the rest of the application source code
COPY src /app/src

# Package the application using Maven
RUN mvn clean package

# Use an official OpenJDK runtime as a parent image for the final image
FROM openjdk:17-slim

# Set the working directory for the app
WORKDIR /app

# Copy the packaged application from the build image
COPY --from=build /app/target/*.jar /app/app.jar

# Expose the port that the app will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
