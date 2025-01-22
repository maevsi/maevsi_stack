const fs = require('fs');

const postgisPlugin = require("@graphile/postgis");

module.exports = {
    options: {
        appendPlugins: [postgisPlugin.default || postgisPlugin],
        connection: fs.readFileSync(process.env.POSTGRAPHILE_CONNECTION_FILE, 'utf8'),
        defaultRole: 'maevsi_anonymous',
        dynamicJson: true,
        enhanceGraphiql: true,
        extendedErrors: ['errcode'],
        host: '0.0.0.0',
        ignoreRBAC: false,
        jwtPublicKey: fs.readFileSync(process.env.POSTGRAPHILE_JWT_PUBLIC_KEY_FILE, 'utf8'),
        jwtSecret: fs.readFileSync(process.env.POSTGRAPHILE_JWT_SECRET_KEY_FILE, 'utf8'),
        jwtSignOptions: { algorithm: 'RS256' },
        jwtTokenIdentifier: 'maevsi.jwt',
        jwtVerifyAlgorithms: ['RS256'],
        ownerConnection: fs.readFileSync(process.env.POSTGRAPHILE_OWNER_CONNECTION_FILE, 'utf8'),
        schema: ['maevsi'],
        setofFunctionsContainNulls: false,
        watch: true
    },
};
