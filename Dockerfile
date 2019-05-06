FROM openjdk:8
WORKDIR /app
COPY . /app
RUN ./gradlew clean && ./gradlew war && ./gradlew cargoConfigureLocal

FROM openjdk:8-jre-alpine
WORKDIR /app

COPY --from=0 /app/uaa/build/libs/*.war .
COPY --from=0 /app/statsd/build/libs/*.war .
COPY --from=0 /app/build/extract/tomcat-9.0.13/apache-tomcat-9.0.13 ./tomcat
COPY --from=0 /app/scripts/cargo/tomcat-conf/context.xml /app/config

RUN chmod +x ./tomcat/bin/catalina.sh
ENV CONF_DIR /app/config

EXPOSE 8443
CMD ["./tomcat/bin/catalina.sh", "run"]
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
