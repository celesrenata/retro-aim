#!/bin/bash
set -x
# Check for config

if ! [ -f /app/data/settings.env ]; then
	cp /usr/share/retro_aim_server/settings.env /app/data/settings.env
fi

/usr/bin/retro_aim_server -config /app/data/settings.env 2>&1 > /app/data/server.log
exec "$@"
