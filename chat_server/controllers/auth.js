const { response } = require("express");

const Usuario = require('../models/usuario');

const crearUsuario = async (req, res = response) => {
    const { email } = req.body;

    try {
        const existeEmail = await Usuario.findOne({ email });

        if ( existeEmail ) {
            return res.status(400).json({
                msg: 'El correo ya está registrado',
                ok: false
            });
        }

        const usuario = new Usuario( req.body );

        await usuario.save();

        res.json({
            ok: true,
            usuario
        });
    } catch (error) {
        console.log(error);

        res.status(500).json({
            msg: 'Hable con el administrador',
            ok: false
        })
    }
}

module.exports = {
    crearUsuario
}
