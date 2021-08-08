const jwt = require('jsonwebtoken');

const validarJWT = (req, res, next) => {
    const token = req.header('x-token');

    if ( !token ) {
        return res.status(401).json({
            msg: 'No hay token en la patición',
            ok: false
        });
    }

    try {
        const { uid } = jwt.verify( token, process.env.JWT_KEY );

        req.uid = uid;

        next();
    } catch(error) {
        return res.status(401).json({
            msg: 'Token no válido',
            ok: false
        });
    }
}

module.exports = {
    validarJWT
}
