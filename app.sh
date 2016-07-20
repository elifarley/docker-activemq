#!/bin/sh
(cd /usr/local/apache-activemq/conf && rm -f jetty-realm.properties users.properties)

exec activemq-nowrapper
