//Imports
const { Router, json } = require('express');

//Objeto donde definimos rutas del servidor
const router = Router();

//Modelo del usuario
const Usuario = require('../models/user-model');


//Registro de usuario

    try {

        router.get('/api/user', async (req,res)=>{

            //Buscar todos los negocios dentro de la base de datos
            const usuarios = await Usuario.find();
            const usuario = usuarios.filter((e)=>e.googleId==req.get('googleId'));
            res.json( usuario );
        });


        //Obtener googleId y Email
        router.post('/api/user-model/create', async (req,res)=>{

            const google_Id = req.body.googleId;
            const user_name = req.body.UserName;
            const email_user = req.body.EmailUser;
            const _avatar = req.body.avatar;



            //Usuario existe o no
            Usuario.findOne({EmailUser: email_user })
                .then((docs)=>{
                    console.log("Result :",docs);
                    return docs;
                })
                .catch((err)=>{
                    console.log(err);
                });
            console.log(userFind)

            if(userFind == null){

                console.log("Usuario creado")
                   //UserCreate
                await Usuario.create({
                        
                    googleId: google_Id,
                    UserName: user_name,
                    EmailUser: email_user,
                    avatar: _avatar

                });
                
            }

              //Usuario 
                console.log("No entro a crear")
                res.status(201).send({
                    "status_code":201,
                    'googleId': google_Id,
                    'UserName': user_name,
                    'EmailUser': email_user,
                    'avatar': _avatar,
                    })  
 

        });

        

        
    } catch (error) {
        
        console.log(error);
        return res.json({
            succes:false,
            msg:'Error al registrar'
        });

    }


module.exports = router