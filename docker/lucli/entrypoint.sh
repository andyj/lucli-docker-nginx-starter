#!/usr/bin/env sh
set -eu

: "${LUCLI_HOME:=/opt/lucli/home}"
: "${LUCLI_PORT:=8080}"
: "${LUCLI_WEBROOT:=/var/www}"

mkdir -p "${LUCLI_HOME}"

if [ ! -d "${LUCLI_WEBROOT}" ]; then
  echo "Expected CFML webroot at ${LUCLI_WEBROOT} but it does not exist" >&2
  exit 1
fi

exec java -jar /opt/lucli/lucli.jar server run \
  --port "${LUCLI_PORT}" \
  --webroot "${LUCLI_WEBROOT}"
