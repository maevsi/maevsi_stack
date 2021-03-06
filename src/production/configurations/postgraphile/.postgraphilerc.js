const fs = require('fs');

module.exports = {
    options: {
        connection: fs.readFileSync('/run/secrets/postgraphile_connection', 'utf8'),
        defaultRole: 'maevsi_anonymous',
        enhanceGraphiql: true,
        host: '0.0.0.0',
        ignoreRBAC: false,
        jwtSecret: fs.readFileSync('/run/secrets/postgraphile_jwt-secret', 'utf8'),
        jwtTokenIdentifier: 'maevsi.jwt',
        ownerConnection: fs.readFileSync('/run/secrets/postgraphile_owner-connection', 'utf8'),
        schema: ['maevsi'],
        watch: true
    },
};
