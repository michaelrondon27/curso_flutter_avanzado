/* 
    path: api/login
*/

const { Router } = require('express');
const { crearUsuario } = require('../controllers/auth');

const router = Router();

router.post('/new', crearUsuario);

module.exports = router;
