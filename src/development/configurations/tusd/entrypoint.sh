#!/usr/bin/env bash

update-ca-certificates

su -c "/usr/local/share/docker-entrypoint.sh" -m "tusd" -- "$@"