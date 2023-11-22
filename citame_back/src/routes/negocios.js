const { Router, json } = require('express');

//Objeto donde definimos rutas del servidor
const router = Router();

//Solicitud para obtener el modelo de negocio
const Usuario = require('../models/user-model');
const Negocio = require('../models/negocio-model');
const { default: mongoose } = require('mongoose');


//Ruta para cargar la lista de negocios
router.get('/api/negocios', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( {negocios} );
});



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
    const workers = req.body.workers;
    const contactNumber = req.body.contactNumber;
    const direction = req.body.direction;
    const latitude = req.body.latitude;
    const longitude = req.body.longitude;
    const description = req.body.description;
    Usuario.findOne({EmailUser: email})
    .then(async (docs)=>{
        console.log(docs._id);
        console.log(docs.EmailUser);
        if(docs.EmailUser == email){
            await Negocio.create({
                businessName: businessName,
                category: category,
                email: email,
                createdBy: docs._id,
                workers: workers,
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
                "createdBy": docs,
                "workers": workers,
                "contactNumber": contactNumber,
                "direction": direction,
                "latitude": latitude,
                "longitude": longitude,
                "description": description,
            }
            )
        }
    })
    .catch((err)=>{
        console.log(err);
    });

   

});

router.get('/api/a', async (req,res)=>{

    //email recibido
    const email =  req.get('email');

    //Encontrar los negocios del usuario
    try {
        
        //Consulta para encontrar los negocios
        Usuario.findOne({EmailUser: email})
    .then(async (docs)=>{
        console.log(docs._id);
        console.log(docs.EmailUser);
        if(docs.EmailUser == email){

            const negociosUsuario = await Negocio.find({  createdBy: docs._id  });
            
            res.json(negociosUsuario);
            
        }
    })
    .catch((err)=>{
        console.log(err);
    });



    

    } catch (error) {
        
        console.log(error);
        return res.json({
            succes:false,
            msg:'Error al registrar'
        });

    }



});



module.exports = router
