const { response } = require("express");

const crearUsuario = (req, res = response) => {
    res.json({
        msg: 'Crear Usuario',
        ok: true
    });
}

module.exports = {
    crearUsuario
}
