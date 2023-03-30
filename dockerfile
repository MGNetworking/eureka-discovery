# Stage Build
FROM maven:3.8.5-jdk-8-slim as build

COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean test package -Dspring.profiles.active=prod

# Stage package
FROM openjdk:8-jdk-alpine

COPY --from=build /home/app/target/*.jar app.jar

EXPOSE 8099
ENTRYPOINT [ "java" ,"-jar", "app.jar" ]

# docker build -t eureka/latest .

# docker run -e "SPRING_PROFILES_ACTIVE=dev" --name eureka -p 8099:8099 -d eureka/latest -t