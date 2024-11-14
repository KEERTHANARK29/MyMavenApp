# Use official Tomcat image as a base image
FROM tomcat:9-jdk11-openjdk-slim

# Set the working directory inside the container
WORKDIR /usr/local/tomcat/webapps

# Copy the war file to Tomcat's webapps folder
COPY target/MyMavenApp.war /usr/local/tomcat/webapps/MyMavenApp.war

# Expose the port Tomcat will run on (by default, Tomcat runs on 8080)
EXPOSE 8000

# Start Tomcat server
CMD ["catalina.sh", "run"]
