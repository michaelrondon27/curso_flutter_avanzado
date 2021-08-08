const { response } = require("express");
const { validationResult } = require("express-validator");

const crearUsuario = (req, res = response) => {
    const errores = validationResult( req );

    if ( !errores.isEmpty() ) {
        return res.status(400).json({
            errors: errores.mapped(),
            ok: false
        });
    }

    res.json({
        msg: 'Crear Usuario',
        ok: true
    });
}

module.exports = {
    crearUsuario
}
