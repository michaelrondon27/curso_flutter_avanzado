const { io } = require('../index');
const { comprobarJWT } = require('../helpers/jwt');

// Mensajes de Sockets
io.on('connection', client => {

    const [valido, uid] = comprobarJWT( client.handshake.headers['x-token'] );

    if ( !valido ) { return client.disconnect(); }

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });
});