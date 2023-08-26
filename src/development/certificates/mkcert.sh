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

echo "key crt" | tr ' ' '\n' | while read -r glob; do
    if test -n "$(find "$THIS" -maxdepth 1 -name "*.$glob" -print -quit)"; then
        rm "$THIS"/*."$glob"
    fi
done

create "root"
create "traefik" \
    `# adminer` "adminer.localhost" \
    `# maevsi` "localhost" "www.localhost" "127.0.0.1" "0.0.0.0" \
    `# minio` "minio.localhost" \
    `# portainer` "portainer.localhost" \
    `# postgraphile` "postgraphile.localhost" \
    `# rabbitmq` "rabbitmq.localhost" \
    `# stomper` "stomper.localhost" \
    `# traefik` "traefik.localhost" \
    `# tusd` "tusd.localhost"