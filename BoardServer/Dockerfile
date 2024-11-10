FROM openjdk
WORKDIR /app
EXPOSE 8080
ARG JAR_FILE=build/libs/BoardServer-0.0.1.jar
COPY ${JAR_FILE} app.jar
WORKDIR /app
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
