#!/bin/sh
test -L /data/activemq.log -o -e /data/activemq.log && ls -Falk /data/activemq.log || {
  ln -sf /proc/self/fd/1 /data/activemq.log || return
}
exec activemq-nowrapper
