#!/bin/sh
set -eu

: "${BASIC_AUTH_USERNAME:?BASIC_AUTH_USERNAME must be set}"
: "${BASIC_AUTH_PASSWORD:?BASIC_AUTH_PASSWORD must be set}"
: "${GODS_EYE_UPSTREAM:?GODS_EYE_UPSTREAM must be set}"

upstream_host="${GODS_EYE_UPSTREAM%%:*}"
printf '[gateway] Upstream configured: %s\n' "$GODS_EYE_UPSTREAM"
printf '[gateway] Resolver config follows:\n'
cat /etc/resolv.conf
printf '[gateway] Internal hostname lookup follows:\n'
nslookup "$upstream_host" 2>&1 || true
printf '[gateway] Discovery hostname lookup follows:\n'
nslookup "${upstream_host}-discovery" 2>&1 || true

mkdir -p /etc/nginx/auth
umask 077
htpasswd -B -C 12 -b -c /etc/nginx/auth/htpasswd "$BASIC_AUTH_USERNAME" "$BASIC_AUTH_PASSWORD"
