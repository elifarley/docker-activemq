FROM elifarley/docker-alpine-oraclejdk8
MAINTAINER Elifarley <elifarley@gmail.com>
ENV \
  BASE_IMAGE=elifarley/docker-alpine-oraclejdk8 \
\
TINI_VERSION='v0.5.0' TINI_SHA=066ad710107dc7ee05d3aa6e4974f01dc98f3888 \
GOSU_VERSION='1.5' GOSU_SHA=18cced029ed8f0bf80adaa6272bf1650ab68f7aa \
_USER=app \
LANG=en_US.UTF-8 TZ=${TZ:-Brazil/East} \
TERM=xterm-256color
ENV HOME=/$_USER JAVA_TOOL_OPTIONS="-Duser.timezone=$TZ"

EXPOSE 61612 61613 61616 8161
ENTRYPOINT ["/bin/tini", "--", "/entry.sh"]
CMD ["/app/app.sh"]

WORKDIR $HOME

RUN \
  xinstall save-image-info && \
  xinstall add-user "$_USER" && \
  xinstall add activemq 5.13.3 c19e2717f5c844a2f271fcd39eb024d04ebcfa5d && \
  chown -R "$_USER":"$_USER" /usr/local/apache-activemq* && \
  xinstall add tini "$TINI_VERSION" "$TINI_SHA" && \
  xinstall add gosu "$GOSU_VERSION" "$GOSU_SHA" && \
  xinstall add-base && \
  xinstall cleanup

COPY $_USER.sh $HOME/
RUN chmod +x "$HOME"/$_USER.sh && chown "$_USER":"$_USER" "$HOME"/$_USER.sh

VOLUME /data /tmp/activemq
