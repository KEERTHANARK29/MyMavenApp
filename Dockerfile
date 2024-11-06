# Use Maven 3.8.6 with OpenJDK 17 as the build environment
FROM maven:3.8.6-jdk-17-slim AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code into the container
COPY src /app/src

# Build the app using Maven
RUN mvn clean package

# Use OpenJDK runtime to create the final image
FROM openjdk:17-slim

# Set the working directory for the app
WORKDIR /app

# Copy the packaged application from the build container
COPY --from=build /app/target/*.jar /app/app.jar

# Expose the port your app will use
EXPOSE 8080

# Set the command to run your app
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
