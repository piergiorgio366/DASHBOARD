#!/bin/sh
set -eu

: "${BASIC_AUTH_USERNAME:?BASIC_AUTH_USERNAME must be set}"
: "${BASIC_AUTH_PASSWORD:?BASIC_AUTH_PASSWORD must be set}"
: "${GODS_EYE_UPSTREAM:?GODS_EYE_UPSTREAM must be set}"

mkdir -p /etc/nginx/auth
umask 077
htpasswd -B -C 12 -b -c /etc/nginx/auth/htpasswd "$BASIC_AUTH_USERNAME" "$BASIC_AUTH_PASSWORD"
