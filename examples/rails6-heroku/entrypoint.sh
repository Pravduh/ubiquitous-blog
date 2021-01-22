#!/bin/bash -e

# Remove to avoid any potential dev issue
rm -f /app/tmp/pids/server.pid

echo "$@"

# Pass over to the container's main process
exec "$@"
