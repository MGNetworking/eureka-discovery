# Définition de l'image de base
FROM maven:3.8.5-jdk-8-slim as build

# Création du répertoire de travail
WORKDIR /app

COPY src /app/src
COPY pom.xml /app/pom.xml
RUN mvn clean test package -Dspring.profiles.active=dev -Dspring-boot.run.jvmArguments=-Dspring.profiles.active=dev

# Image de base pour l'exécution de l'application
FROM openjdk:8-jdk-alpine

# Définition de l'utilisateur
USER root

# Création du répertoire de travail
RUN mkdir /app
WORKDIR /app

# Copie du jar de l'application
COPY --from=build /app/target/*.jar /app/app.jar

# Définition de la variable d'environnement pour activer le profil "dev"
ENV SPRING_PROFILES_ACTIVE=dev

# Exposition du port 8099 pour l'application
EXPOSE 8099

# Lancement de l'application
ENTRYPOINT [ "java" ,"-jar", "app.jar" ]

# docker build -t eureka/latest .

# docker run -e "SPRING_PROFILES_ACTIVE=dev" --name eureka -p 8099:8099 -d eureka/latest -t