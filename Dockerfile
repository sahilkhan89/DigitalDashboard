# FROM maven:3.8.5-openjdk-17 AS build
# COPY . .
# RUN mvn clean package -DskipTests

# FROM openjdk:17.0.1-jdk-slim
# COPY --from=build /target/digital_board-0.0.1-SNAPSHOT.jar demo.jar
# EXPOSE 9090
# ENTRYPOINT ["java","-jar","digital_board.jar"]
FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN ./gradlew bootJar --no-daemon

FROM openjdk:17-jdk-slim

EXPOSE 9090

COPY --from=build /build/libs/digital_board-1.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]