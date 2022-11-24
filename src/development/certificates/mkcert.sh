#!/bin/sh
THIS=$(dirname "$(readlink -f "$0")")

create() {
    NAME="$1"
    shift
    CONTENT=$*

    path="$THIS/$NAME"
    certfile="$path.crt"
    keyfile="$path.key"

    if [ "$CONTENT" != "" ]; then
        # shellcheck disable=SC2086
        mkcert \
            -cert-file "$certfile" \
            -ecdsa \
            -key-file "$keyfile" $CONTENT
    fi

    cat "$(mkcert -CAROOT)/rootCA.pem" >> "$certfile"
}

rm "$THIS"/*.key "$THIS"/*.crt

create "root"
create "traefik" "127.0.0.1" "0.0.0.0" "localhost" "www.localhost" "alpha.localhost" "beta.localhost" "adminer.localhost" "minio.localhost" "portainer.localhost" "postgraphile.localhost" "rabbitmq.localhost" "stomper.localhost" "traefik.localhost" "tusd.localhost"