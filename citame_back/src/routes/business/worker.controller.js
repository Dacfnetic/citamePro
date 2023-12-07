//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const workers = require('../../models/worker.model.js');

async function postWorkers(req,res){
    try{
        workers.findOne({email: req.body.email})
        .then(async (docs)=>{
            if(docs == null){
                console.log('Creando Trabajador');
                await workers.create({
                    name: req.body.name,
                    email: req.body.email,
                    imgPath:req.body.imgPath,
                    salary :req.body.salary,
                    horario:req.body.horario,
                    status: req.body.status
                });
                return res.status(201).send({'sms':'Trabajador creado'});
            }
            return res.status(202).send({'sms': 'El Trabajador ya existe'});
        })
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}


module.exports  = {

    postWorkers

}
