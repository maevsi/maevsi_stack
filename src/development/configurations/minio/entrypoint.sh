#!/bin/sh

# create dirs for required buckets
mkdir -p /data/maevsi-backup
mkdir -p /data/maevsi-images

# delegate to real entrypoint
# shellcheck disable=SC1091
. /usr/bin/docker-entrypoint.sh