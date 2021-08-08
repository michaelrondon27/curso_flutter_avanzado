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

UsuarioSchema.method('toJSON', function() {
    const { __v, _id, password, ...object } = this.toObject();

    object.uid = _id;

    return object;
});

module.exports = model('Usuario', UsuarioSchema);
