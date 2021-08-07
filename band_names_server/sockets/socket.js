const { io } = require('../index');
const Band = require('../models/band');
const Bands = require('../models/bands');

const bands = new Bands();

bands.addBand( new Band('Queen') );
bands.addBand( new Band('Bon Jovi') );
bands.addBand( new Band('Héroes del Silencio') );
bands.addBand( new Band('Metallica') );

// Mensajes de Sockets
io.on('connection', client => {
    console.log('Cliente conectado');

    client.emit('active-bands', bands.getBands() );

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });

    client.on('mensaje', ( payload ) => {
        console.log('Mensaje!!!', payload);

        io.emit( 'mensaje', { admin: 'Nuevo mensaje' });
    });

    client.on('emitir-mensaje', ( payload ) => {
        client.broadcast.emit('nuevo-mensaje', payload);
    });
});