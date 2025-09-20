FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file
COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]