//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const workers = require('../../models/worker.model.js');

async function postWorkers(req,res){
    try{
<<<<<<< HEAD:citame_back/src/routes/business/worker.controller.js
        let existe = true;
        business.findOne({email: req.body.email})
=======
        /* let existe = true;
        workers.findOne({email: req.body.email})
>>>>>>> 1a78631bdd8856ec18ee30a0bd9b5556ac20bfce:citame_back/src/routes/workers/worker.controller.js
        .then(async (docs)=>{
            if(docs == null){
                existe = false;
        }});
        //if(existe) return res.status(201).send('El worker ya esta en el negocio');
        usuario.findOne({emailUser: req.body.email})
        .then(async (docs)=>{
            if(docs != null){
                console.log('Creando Trabajador');
                await workers.create({
                    id: docs._id,
                    name: req.body.name,
                    email: req.body.email,
                    imgPath:req.body.imgPath,
                    salary :req.body.salary,
                    horario:req.body.horario,
                    status: req.body.status,
                    puesto: req.body.puesto
                });
                return res.status(201).send({'sms':'Trabajador creado'});
            }
            return res.status(202).send({'sms': 'El Trabajador ya existe'});//Cambiar porque est[a raro]
        });
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}

async function deleteWorkers(req,res){
    
}

module.exports  = {

    postWorkers

}
