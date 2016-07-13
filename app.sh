#!/bin/sh
test -L /data/activemq.log -o -e /data/activemq.log && ls -Falk /data/activemq.log || {
  ln -vsf /proc/self/fd/1 /data/activemq.log || return
}

(cd /usr/local/apache-activemq/conf && rm -f jetty-realm.properties users.properties)

exec activemq-nowrapper
