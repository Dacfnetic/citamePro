const { Router, json } = require('express');
const Multer = require('multer');

//---Objeto donde definimos rutas del servidor---//
const router = Router();


//Solicitud para obtener el modelo de negocio
const Usuario = require('../models/user-model');
const Negocio = require('../models/negocio-model');

//---Ruta para cargar la lista de negocios---//
router.get('/api/negocios', async (req,res)=>{

    //Buscar todos los negocios dentro de la base de datos
    const negocios = await Negocio.find();
    res.json( negocios );
});

//---Ruta para ver negocios del usuario que inicio sesion---//


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

//---Imagenes del Servidor---//

//Metodo para almacenar las imagenes
const imgStorage = Multer.diskStorage({

    destination: function (req,file,cb){
        cb(null,'subidas/'); //Directorio donde se guardan las imagenes
    },

    filename: function(req,file,cb){
        cb(null,file.originalname);
    }


});

const imgSubida = Multer({ storage: imgStorage });

//---Ruta para las imagenes del servidor---//
router.post('/api/subida', imgSubida.single('image') , async (req,res)=>{

    try {
        
        const patImg = req.file.path;

        //Save en mongo

        const newImage = new Negocio({  imgPath: patImg });
        await newImage.save();
        res.json({ message:'Imagen Guardada en MongoDB exitosamente.'} );



    } catch (error) {
        console.log(error);
        return res.json({
            succes:false,
            msg:'Error al subir'
        });
        
    }




});

module.exports = router;
