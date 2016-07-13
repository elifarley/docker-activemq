FROM elifarley/docker-alpine-oraclejdk8
MAINTAINER Elifarley <elifarley@gmail.com>
ENV \
  BASE_IMAGE=elifarley/docker-alpine-oraclejdk8 \
\
GOSU_VERSION='1.5' TINI_VERSION='v0.5.0' \
_USER=app \
LANG=en_US.UTF-8 TZ=${TZ:-Brazil/East} \
TERM=xterm-256color
ENV HOME=/$_USER JAVA_TOOL_OPTIONS="-Duser.timezone=$TZ"

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/entrypoint"]
CMD ["/app/app.sh"]

WORKDIR $HOME

RUN \
  xinstall save-image-info && \
  xinstall add-user "$_USER" && \
  xinstall add gosu "$GOSU_VERSION" && \
  xinstall add tini "$TINI_VERSION" && \
  xinstall add entrypoint && \
  xinstall add activemq 5.13.3 && \
  xinstall cleanup && \
  (\
    cd /usr/local/apache-activemq/conf && \
    chown :$_USER . jetty-realm.properties users.properties && \
    chmod g=u . jetty-realm.properties users.properties \
  )

COPY $_USER.sh $HOME/
RUN chmod +x "$HOME"/$_USER.sh && chown "$_USER":"$_USER" "$HOME"/$_USER.sh

EXPOSE 61612 61613 61616 8161

VOLUME /data
