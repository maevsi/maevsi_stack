#!/bin/sh

set -eu

username="$(cat /run/secrets/postgres_user)"

create_database() {
    create_database_database=$1
    echo "Creating user and database '$create_database_database'"
    psql -v ON_ERROR_STOP=1 --username "$username" --dbname "postgres" <<-EOSQL
        CREATE DATABASE "$create_database_database";
EOSQL
}

if [ -n "${POSTGRES_ADDITIONAL_DBS:-}" ]; then
    echo "Additional database creation requested: $POSTGRES_ADDITIONAL_DBS"

    for db in $POSTGRES_ADDITIONAL_DBS; do
        create_database "$db"
    done

    echo "Multiple databases created"
fi
