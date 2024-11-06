# Use an official Maven image to build the app
FROM maven:3.8.6-openjdk-11 as builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and the source code
COPY pom.xml .
COPY src ./src

# Build the application using Maven
RUN mvn clean package

# Use a minimal OpenJDK image for running the app
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the jar file from the builder image
COPY --from=builder /app/target/MyMavenApp-1.0-SNAPSHOT.jar /app/MyMavenApp.jar

# Expose the port the app will run on (optional, adjust if needed)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "MyMavenApp.jar"]
