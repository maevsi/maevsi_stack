const fs = require('fs');

module.exports = {
    options: {
        connection: fs.readFileSync('/run/secrets/postgraphile_connection', 'utf8'),
        defaultRole: "maevsi_anonymous",
        host: "0.0.0.0",
        jwtSecret: fs.readFileSync('/run/secrets/postgraphile_jwt-secret', 'utf8'),
        jwtTokenIdentifier: "maevsi.jwt",
        ownerConnection: fs.readFileSync('/run/secrets/postgraphile_owner-connection', 'utf8'),
        schema: ["maevsi"],
        watch: true
    },
};