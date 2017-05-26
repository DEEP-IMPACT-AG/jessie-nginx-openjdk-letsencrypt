#!/usr/bin/env bash

set -e

if [ -f /app/init.sh ]; then
	/app/init.sh
fi

exec /usr/bin/supervisord --configuration /etc/supervisord.conf
