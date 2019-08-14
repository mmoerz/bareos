#!/usr/bin/env bash

# MAINTAINER Michael Moerz <michael@moerz.co.at> 

if [ ! -f /etc/bareos/bareos-fd-config.control ]
  then
  tar xfvz /bareos-fd.tgz

  # Force client/file daemon password
  sed -i "s#Password = .*#Password = \"${BAREOS_FD_PASSWORD}\"#" /etc/bareos/bareos-fd.d/director/bareos-dir.conf

  # Control file
  touch /etc/bareos/bareos-fd-config.control
fi

find /etc/bareos/bareos-fd.d ! -user bareos -exec chown bareos {} \;
exec "$@"
