#!/usr/bin/env bash

set -e

if [ -f /app/init.sh ]; then
	sudo su -c '/app/init.sh'
fi

exec /usr/bin/supervisord --configuration /etc/supervisord.conf
