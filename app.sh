#!/bin/sh
test -L /data/activemq.log -o -e /data/activemq.log && ls -Falk /data/activemq.log || {
  ln -vs /dev/console /data/activemq.log || return
}
exec activemq-nowrapper
