#!/usr/bin/env bash
set -exo pipefail

ACTION="$1"

set -u

if [[ "stop" == "$ACTION" ]]; then
  docker-compose down
elif [[ "destroy" == "$ACTION" ]]; then
  docker-compose down --volumes
elif [[ "up" == "$ACTION" ]]; then
  docker-compose up -d
elif [[ "logs" == "$ACTION" ]]; then
  docker-compose logs
else
  docker-compose ps
fi
