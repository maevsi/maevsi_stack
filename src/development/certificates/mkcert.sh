#!/bin/sh
THIS=$(dirname "$(readlink -f "$0")")
NAME=maevsi

mkcert \
-cert-file "$THIS/$NAME.crt" \
-ecdsa \
-key-file "$THIS/$NAME.key" \
    $NAME.test \
    "*.$NAME.test"