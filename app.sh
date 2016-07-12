#!/bin/sh
test -e /data/activemq.log && ls -Falk /data/activemq.log || {
  ln -vs /dev/console /data/activemq.log || return
}
exec activemq-nowrapper
