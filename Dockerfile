FROM maven:3-openjdk-11

WORKDIR /root
COPY . ./
RUN mvn clean package
RUN mv $(find /root/target/ -type f -name '*.jar' -a ! -name '*-javadoc.jar' -a ! -name '*-sources.jar' -a ! -name '*-tests.jar') /root/app.jar

FROM openjdk:11-alpine
WORKDIR /var/app
COPY --from=0 /root/app.jar /var/app/app.jar
CMD ["java", "-jar", "app.jar"]