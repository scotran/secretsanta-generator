FROM openjdk:17-slim
WORKDIR /app
RUN apt-get update && apt-get install -y maven
COPY . .
RUN mvn clean package
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "target/secretsanta-0.0.1-SNAPSHOT.jar"]
