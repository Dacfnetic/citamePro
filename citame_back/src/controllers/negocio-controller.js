const { Router, json } = require('express');

//Objeto donde definimos rutas del servidor
const router = Router();

//Solicitud para obtener el modelo de negocio

const Negocio = require('../models/negocio-model');

//Ruta para cargar la lista de negocios
router.get('/api/negocios', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( negocios );
});

//Ruta para ver negocios del usuario que inicio sesion

router.get('/api/negocios-user/userId', async (req,res)=>{

    //ID recibido
    const userId =  req.params.userId;


    //Encontrar los negocios del usuario

    try {
        
        //Consulta para encontrar los negocios
        const negociosUsuario = await Negocio.find({  createdBy: userId  });

        res.json(negociosUsuario);

    } catch (error) {
        
        console.log(error);
        return res.json({
            succes:false,
            msg:'Error al registrar'
        });

    }



});

