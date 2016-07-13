#!/bin/sh
test -L /data/activemq.log -o -e /data/activemq.log && ls -Falk /data/activemq.log || {
  ln -vsf /proc/self/fd/1 /data/activemq.log || return
}

rm -f \
/usr/local/apache-activemq/conf/jetty-realm.properties \
/usr/local/apache-activemq/conf/users.properties

exec activemq-nowrapper
