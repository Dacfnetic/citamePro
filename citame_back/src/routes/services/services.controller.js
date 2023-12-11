//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const services = require('../../models/services.model.js');

async function getServices(req,res){
    
    try{
        business.findOne({email: req.get('email')})
            .then(async(docs)=>{
                if(docs.email == req.get('email')){
                    const allServices = await services.find({nombreServicio: req.get('nombreServicio')});
                    return res.status(200).json(allServices);
                }
            }).catch(e=>console.log(e));
    }catch(e){
        return res.status(404).json('Errosillo');
    }  


}

async function postServices(req,res){

    try{
        
        business.findOne({email: req.body.email})
        .then(async (docs)=>{
            if(docs != null){
                console.log('Creando Servicio');
                await services.create({
                    nombreServicio: req.body.nombreServicio,
                    businessCreatedBy : docs._id,
                    precio: req.body.precio,
                    imgPath: req.body.imgPath,
                    descripcion: req.body.descripcion
                });
                return res.status(201).send({'sms':'Servicio creado'});
            }
            return res.status(202).send({'sms': 'El Servicio ya existe'});//Cambiar porque est[a raro]
        });
    }catch(e){
        return res.status(404).json('Errosillo');
    }  

};

async function deleteService(req,res){

};

async function updateService(req,res){

};

module.exports = {
    getServices,
    postServices,
    deleteService,
    updateService
}