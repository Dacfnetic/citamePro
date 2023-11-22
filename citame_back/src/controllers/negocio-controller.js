const { Router, json } = require('express');

//Objeto donde definimos rutas del servidor
const router = Router();

//Solicitud para obtener el modelo de negocio
const Usuario = require('../models/user-model');
const Negocio = require('../models/negocio-model');

//Ruta para cargar la lista de negocios
router.get('/api/negocios', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( negocios );
});

//Ruta para ver negocios del usuario que inicio sesion

module.exports = router