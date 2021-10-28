#!/bin/sh
# create dirs for required buckets
mkdir -p /data/maevsi-backup
# delegate to real entrypoint
. /usr/bin/docker-entrypoint.sh