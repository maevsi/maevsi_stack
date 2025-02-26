#!/bin/sh

set -eu

username="$(cat /run/secrets/postgres_user)"

create_database_and_role() {
    db_name="$1"
    password_file="/run/secrets/postgres_role_${db_name}_password"
    username_file="/run/secrets/postgres_role_${db_name}_username"

    if [ ! -f "$password_file" ]; then
        echo "[WARN] Password file for '$db_name' not found, skipping creation" >&2
        return
    fi

    if [ ! -f "$username_file" ]; then
        echo "[WARN] Username file for '$db_name' not found, skipping creation" >&2
        return
    fi

    db_password="$(tr -d '\n' < "$password_file")"
    db_username="$(tr -d '\n' < "$username_file")"

    echo "[INFO] Creating user and database: '$db_name'"

    psql -v ON_ERROR_STOP=1 --username "$username" --dbname "postgres" <<-EOSQL
        CREATE ROLE "$db_username" WITH LOGIN PASSWORD '$db_password';
        CREATE DATABASE "$db_name" OWNER "$db_username";
EOSQL
}

if [ -n "${POSTGRES_ADDITIONAL_DBS:-}" ]; then
    echo "[INFO] Additional database creation requested: $POSTGRES_ADDITIONAL_DBS"

    for db in $POSTGRES_ADDITIONAL_DBS; do
        create_database_and_role "$db"
    done

    echo "[INFO] Multiple databases and roles created"
fi
