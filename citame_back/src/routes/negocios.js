const { Router, json } = require('express');

//Objeto donde definimos rutas del servidor
const router = Router();

//Solicitud para obtener el modelo de negocio

const Negocio = require('../models/negocio-model');


//Ruta para cargar la lista de negocios
router.get('/api/negocios', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( {negocios} );
});

//Ruta para cargar la lista de negocios del usuario
/*
router.get('/api/user', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const usuarios = await Usuario.find();
    const usuario = usuarios.filter((e)=>e.googleId==req.get('googleId'));
    res.json( usuario );
});*/

//Ruta para cargar la lista de negocios del usuario
router.get('/api/user_businesses', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( negocios );
});

//Ruta para crear negocio
router.post('/api/negocio-model/create', async (req,res)=>{

    const businessName = req.body.businessName;
    const category = req.body.category;
    const email = req.body.email;
    const contactNumber = req.body.contactNumber;
    const direction = req.body.direction;
    const latitude = req.body.latitude;
    const longitude = req.body.longitude;
    const description = req.body.description;

    await Negocio.create({
        businessName: businessName,
        category: category,
        email: email,
        contactNumber: contactNumber,
        direction: direction,
        latitude: latitude,
        longitude: longitude,
        description: description,
    });

    res.status(201).send({
        "status_code":201,
        "businessName": businessName,
        "category": category,
        "email": email,
        "contactNumber": contactNumber,
        "direction": direction,
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
    }
)

});



module.exports = router
