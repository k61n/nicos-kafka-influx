#!/bin/bash

echo "Starting nicos container."

terminate_app() {
  kill -TERM "$child" 2>/dev/null
  wait "$child"
  exit 0
}

trap 'terminate_app' SIGTERM
while true; do sleep 1; done &
child=$!
wait "$child"
