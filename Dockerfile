FROM openjdk:8
WORKDIR /app
COPY . /app
RUN ./gradlew clean war
RUN find . -name "*tomcat*"

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=0 /app/uaa/build/libs/*.war .
COPY --from=0 /app/statsd/build/libs/*.war .
COPY --from=0 /app/build/extract/tomcat-8.5.23/apache-tomcat-8.5.23/bin/catalina.sh .
RUN chmod +x catalina.sh
EXPOSE 8080
CMD ["catalina.sh", "run"]
#CMD [ \
#  "java", \
#  "-Dspring.profiles.active=dev,dev-h2", \
#  "-Dlogging.config=log4j2.properties", \
#  "-Dauth-server.trust_store=auth_server_trust_store.jks", \
#  "-Dserver.ssl.key_store=key_store.jks", \
#  "-Dserver.ssl.trust_store=trust_store.jks", \
#  "-jar", \
#  "credhub.jar" \
#]
