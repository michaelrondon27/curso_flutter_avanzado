const { response } = require("express");
const bcrypt = require('bcryptjs');

const Usuario = require('../models/usuario');

const crearUsuario = async (req, res = response) => {
    const { email, password } = req.body;

    try {
        const existeEmail = await Usuario.findOne({ email });

        if ( existeEmail ) {
            return res.status(400).json({
                msg: 'El correo ya está registrado',
                ok: false
            });
        }

        const usuario = new Usuario( req.body );

        const salt = bcrypt.genSaltSync();
        
        usuario.password = bcrypt.hashSync( password, salt );

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
