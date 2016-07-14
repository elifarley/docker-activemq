FROM elifarley/docker-cep:alpine-jdk-8
MAINTAINER Elifarley <elifarley@gmail.com>

VOLUME /data
EXPOSE 61612 61613 61616 8161

RUN \
  xinstall add activemq 5.13.3 && \
  xinstall cleanup && \
  (\
    cd /usr/local/apache-activemq/conf && \
    chown :$_USER .. . jetty-realm.properties users.properties && \
    chmod g=u .. . jetty-realm.properties users.properties \
  )
