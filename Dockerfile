FROM openjdk:11.0.10-jdk

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt/app

#UPDATING SYSTEM
RUN apt-get update && apt-get install -y git maven

#CODE CLONE
RUN git clone -q https://github.com/springframeworkguru/springbootwebapp

WORKDIR /opt/app/springbootwebapp

#APP BUILD
RUN mvn clean package

ARG JAR_FILE=target/spring-boot-web-0.0.1-SNAPSHOT.jar

RUN cp ${JAR_FILE} /opt/app/app.jar

WORKDIR /opt/app/

EXPOSE 8080

# java -jar /opt/app/app.jar
ENTRYPOINT ["java","-jar","app.jar"]
