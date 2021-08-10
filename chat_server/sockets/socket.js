const { io } = require('../index');
const { comprobarJWT } = require('../helpers/jwt');
const { usuarioConectado, usuarioDesconectado } = require('../controllers/socket');

// Mensajes de Sockets
io.on('connection', client => {
    const [valido, uid] = comprobarJWT( client.handshake.headers['x-token'] );

    if ( !valido ) { return client.disconnect(); }

    usuarioConectado( uid );

    client.join( uid );

    client.on('mensaje-personal', ( payload ) => {
        console.log(payload);
    });

    client.on('disconnect', () => {
        usuarioDesconectado( uid );
    });
});
