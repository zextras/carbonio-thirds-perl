#!/usr/bin/env bash
set -euo pipefail

: "${AMAVIS_HOSTNAME:=carbonio-mta.localdomain}"
: "${AMAVIS_DOMAIN:=localdomain}"
: "${AMAVIS_LOG_LEVEL:=1}"
: "${AMAVIS_MAX_SERVERS:=2}"
: "${AMAVIS_LISTEN_ADDRESS:=127.0.0.1}"
: "${AMAVIS_LISTEN_PORT:=10024}"
: "${AMAVIS_INET_ACL:=127.0.0.1 [::1]}"
: "${AMAVIS_FORWARD_HOST:=127.0.0.1}"
: "${AMAVIS_FORWARD_PORT:=10025}"
: "${AMAVIS_FINAL_VIRUS_DESTINY:=D_REJECT}"
: "${CLAMD_ADDRESS:=127.78.0.17:20000}"

conf=/opt/zextras/conf/amavisd.conf
cp /opt/zextras/conf/amavisd.conf.in "$conf"
for var in AMAVIS_HOSTNAME AMAVIS_DOMAIN AMAVIS_LOG_LEVEL AMAVIS_MAX_SERVERS AMAVIS_LISTEN_ADDRESS \
  AMAVIS_LISTEN_PORT AMAVIS_INET_ACL AMAVIS_FORWARD_HOST AMAVIS_FORWARD_PORT AMAVIS_FINAL_VIRUS_DESTINY \
  CLAMD_ADDRESS; do
  sed -i "s#@@${var}@@#${!var}#g" "$conf"
done

exec /opt/zextras/common/sbin/amavisd -X no_conf_file_writable_check -c "$conf" foreground
