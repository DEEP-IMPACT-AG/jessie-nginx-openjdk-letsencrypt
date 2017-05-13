#!/usr/bin/env bash

set -e

if [ -f /app/init.sh ]; then
	/app/init.sh
fi

/usr/bin/supervisord --configuration /etc/supervisord.conf
