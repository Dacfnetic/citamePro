const { Router } = require('express');

//Objeto donde definimos rutas del servidor
const router = Router();

//Solicitud para obtener el modelo de negocio

const Negocio = require('../models/negocio-model');
const Usuario = require('../models/user-model');

//Ruta para cargar la lista de negocios
router.get('/api/negocios', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( {negocios} );
});

//Ruta para crear negocio
router.get('/api/negocios-model/create', async (req,res)=>{

        await Negocio.create({
            
            nombreNegocio: 'BBC',
            categoria: 'Belleza',
            direccionFisica: '7av 3calle',
            avatar: 'img.jpg'

        });

    res.json({message:'Negocio Creado exitosamente'});

});

router.post('/api/user-model/create', async (req,res)=>{

    const google_Id = req.body.googleId;
    const user_name = req.body.UserName;
    const email_user = req.body.EmailUser;
    const _avatar = req.body.avatar;

    await Usuario.create({
                
        googleId: google_Id,
        UserName: user_name,
        EmailUser: email_user,
        avatar: _avatar

    });

    res.status(201).send({
        "status_code":201,
        'googleId': google_Id,
        'UserName': user_name,
        'EmailUser': email_user,
        'avatar': _avatar,
    }
)

});


module.exports = router
