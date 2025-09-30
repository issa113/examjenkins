FROM openjdk:11-jdk-alpine


WORKDIR /app

COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

RUN ./mvnw dependency:go-offline

COPY src src
RUN ./mvnw package -DskipTests

# Port fixe 8080
EXPOSE 8080

# Utiliser le port de Render ou 8080 par défaut
CMD ["sh", "-c", "java -Dserver.port=${PORT:-8080} -jar target/*.jar"]