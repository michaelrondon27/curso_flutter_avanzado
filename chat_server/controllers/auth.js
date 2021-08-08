const { response } = require("express");
const bcrypt = require('bcryptjs');

const { generarJWT } = require("../helpers/jwt");
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

        const token = await generarJWT( usuario.id );

        res.json({
            ok: true,
            token,
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

const login = async (req, res = response) => {
    const { email, password } = req.body;

    try {
        const usuarioDB = await Usuario.findOne({ email });

        if ( !usuarioDB ) {
            return res.status(400).json({
                msg: 'Email no encontrado',
                ok: false
            });
        }

        const validPassword = bcrypt.compareSync( password, usuarioDB.password );

        if ( !validPassword ) {
            return res.status(400).json({
                msg: 'La contrasela no es válida',
                ok: false
            });
        }

        const token = await generarJWT( usuarioDB.id );

        return res.json({
            ok: false,
            token,
            usuario: usuarioDB
        });
    } catch( error ) {
        console.log(error);

        return res.status(500).json({
            msg: 'Hable con el adminsitrador',
            ok: false
        });
    }
}

module.exports = {
    crearUsuario,
    login
}
