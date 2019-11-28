# maevsi Stack

The Docker stack configuration for [maev.si](https://maev.si/).

This project is deployed in accordance to the [DargStack template](https://github.com/dargmuesli/dargstack_template/) to make deployment a breeze. It is closely related to [maevsi's source code](https://github.com/maevsi/maevsi/).


## Table of Contents
1. **[Secrets](#secrets)**
1. **[Services](#services)**
1. **[Volumes](#volumes)**


## Secrets

- ### `maevsi_sqitch-target`:
  The data base change management application's database connection string.

- ### `portainer_admin-password`:
  The container manager's admin password.

- ### `postgres-backup_db`: ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
  The database's name.

- ### `postgres_db`:
  The database's name.

- ### `postgres_password`:
  The database's password.

- ### `postgres_role_maevsi-postgraphile`:
  The `maevsi_postgraphile` database role's password.

- ### `postgres_user`:
  The database's default user.

- ### `traefik_cf-dns-api-token`: ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
  The DNS provider's DNS API token.

- ### `traefik_cf-zone-api-token`: ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
  The DNS provider's zone API token.


## Services

- ### `adminer`

  You can access the database's frontend at [adminer.maevsi.test](https://adminer.maevsi.test/).
  This information is required for login:

  |          |                     |
  | -------- | ------------------- |
  | System   | PostgreSQL          |
  | Server   | postgres            |
  | Username | [postgres_user]     |
  | Password | [postgres_password] |
  | Database | [postgres_db]       |

  Values in square brackets are [Docker secrets](https://docs.docker.com/engine/swarm/secrets/).

- ### `maevsi`

  You can access the main project at [maevsi.test](https://maevsi.test/).

- ### `portainer`

  You can access the container manager's frontend at [portainer.maevsi.test](https://portainer.maevsi.test).

- ### `portainer-agent`

  You cannot access the container manager's agent directly.

- ### `postgraphile`

  You can access the GraphQL API for the PostgreSQL database at [postgraphile.maevsi.test](https://postgraphile.maevsi.test/).

- ### `postgres`

  You can access the database via `adminer`.

- ### `postgres_backup` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)

  You cannot access the database backup directly.

- ### `traefik`

  You can access the reverse proxy's dashboard at [traefik.maevsi.test](https://traefik.maevsi.test/).

- ### `traefik_certs-dumper` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)

  You cannot access the reverse proxy's certificate helper directly.


## Volumes

- ### `acme_data` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
  The reverse proxy's certificate data.

- ### `portainer_data`
  The container manager's data.

- ### `postgres_data`
  The database's data.
