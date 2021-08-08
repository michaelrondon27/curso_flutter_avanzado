const { model, Schema } = require('mongoose');

const UsuarioSchema = Schema({
    email: {
        required: true,
        type: String,
        unique: true
    },
    nombre: {
        required: true,
        type: String
    },
    online: {
        default: false,
        type: Boolean
    },
    password: {
        required: true,
        type: String
    }
});

module.exports = model('Usuario', UsuarioSchema);
