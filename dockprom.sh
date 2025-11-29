#!/usr/bin/env bash
set -exo pipefail

ACTION="$1"

set -u

if [[ "stop" == "$ACTION" ]] || [[ "down" == "$ACTION" ]]; then
  docker-compose down
elif [[ "destroy" == "$ACTION" ]]; then
  docker-compose down --volumes
elif [[ "start" == "$ACTION" ]] || [[ "up" == "$ACTION" ]]; then
  set +x
  SLACK_URL=$(op read "op://Private/1pcli-dockprom-alertmanager-slackurl/slack_url")
  SLACK_CHANNEL=$(op read "op://Private/1pcli-dockprom-alertmanager-slackurl/slack_channel")
  export SLACK_URL
  export SLACK_CHANNEL
  set -x
  envsubst <./alertmanager/config.yml.template >./alertmanager/config.yml
  docker-compose up -d
elif [[ "logs" == "$ACTION" ]]; then
  docker-compose logs
else
  docker-compose ps
fi
