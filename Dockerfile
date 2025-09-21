# Étape 1 : builder
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copier seulement le pom.xml pour profiter du cache
COPY pom.xml .

# Pré-télécharger les dépendances
RUN mvn dependency:go-offline -B

# Copier le code source
COPY src ./src

# Compiler le projet
RUN mvn clean package -DskipTests -B

# Étape 2 : image finale
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copier le jar depuis l'étape builder
COPY --from=builder /app/target/*.jar app.jar


# Exposer le port si besoin
EXPOSE 8080

# Commande de démarrage
ENTRYPOINT ["java","-jar","app.jar"]
