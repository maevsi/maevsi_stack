#!/bin/sh
THIS=$(dirname "$(readlink -f "$0")")
NAME=maevsi
CERTFILE="$THIS/$NAME.crt"

mkcert \
-cert-file "$CERTFILE" \
-ecdsa \
-key-file "$THIS/$NAME.key" \
    $NAME.test \
    "*.$NAME.test"

cat "$(mkcert -CAROOT)/rootCA.pem" >> "$CERTFILE"