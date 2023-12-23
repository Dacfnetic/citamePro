//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const services = require('../../models/services.model.js');
const path = require('path');
const multer = require('multer');
const app = require('../../app.js');


async function getAllBusiness(req,res){
    console.log('Intentando obtener negocios por categoria');
    try{
        usuario.findOne({emailUser: req.get('email')})
            .then(async(docs)=>{
                if(docs.emailUser == req.get('email')){
                    const allBusiness = await business.find({category: req.get('category')});
                    return res.status(200).json(allBusiness);
                }
            }).catch(e=>console.log(e));
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}
async function getOwnerBusiness(req,res){
    
    try{

        console.log('Intentando obtener negocios del usuario');
        usuario.findOne({emailUser: req.get('email')})
            .then(async(docs)=>{
                if(docs.emailUser == req.get('email')){
                    const ownerBusiness = await business.find({ createdBy: docs._id });
                    console.log('Ya tenemos la lista de negocios del usuario');
                    const comprob =req.get('estado');
                    if(comprob=='1'){
                        console.log('Como no habian cambios no te enviamos nada');
                        return res.status(200).send('1');
                    }
                    console.log('Ahora te vamos a enviar los negocios del usuario, luego te envio las imagenes');
                    return res.status(201).json(ownerBusiness);
                }
            }).catch(e=>console.log(e));
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}
async function verifyOwnerBusiness(req,res){
    console.log('Verificando si los negocios del usuario han cambiado');
    try{
        usuario.findOne({emailUser: req.body.email})
            .then(async(docs)=>{
                if(docs.emailUser == req.body.email){
                    const ownerBusiness = await business.find({ createdBy: docs._id });
                    if(ownerBusiness.length != 0){
                        listaDeNombres = ownerBusiness.map((busi)=> busi.businessName);
                        listaDeNombresOrdenada = listaDeNombres.sort(function(a, b){return b - a});
                        nombresRecibidos = req.body.businessName;
                        listaRecibidaOrdenada = nombresRecibidos.sort(function(a, b){return b - a});
                        if(JSON.stringify(listaRecibidaOrdenada)===JSON.stringify(listaDeNombresOrdenada)){
                            return res.status(200).send('1');
                        }
                    }
                    return res.status(201).send('0');
                }
            }).catch(e=>console.log(e));
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}
async function postBusiness(req,res){
    console.log('Intentando crear negocio');
    try{
        let existe = true;    
        await business.findOne({businessName: req.body.businessName, email: req.body.email, workers:req.body.workers})
            .then((docs) => {
                if(docs == null){
                    existe = false
        }});
        if(existe) return res.status(202).send('El negocio ya existe');
        await usuario.findOne({emailUser: req.body.email})
            .then(async (docs)=>{

                const nuevo = new business({
                    businessName: req.body.businessName,
                    category: req.body.category,
                    email: req.body.email,
                    createdBy: docs._id,
                    workers: req.body.workers,
                    contactNumber: req.body.contactNumber,
                    direction: req.body.direction,
                    latitude: req.body.latitude,
                    longitude: req.body.longitude,
                    description: req.body.description,
                    horario: req.body.horario,
                    servicios: req.body.servicios
                });
                await nuevo.save();
                return res.status(201).json(nuevo);
        });
    }catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }  
}
async function deleteBusiness(req,res){
    console.log('Intentando borrar negocio');
    try{
        let existe = true;    
        await business.findOneAndDelete({businessName: req.body.businessName, email: req.body.email})
        return res.status(200).json({message: 'Todo ok'});
    }catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }  
}
async function updateWorkersInBusinessbyCreateWorker(req,res){
    console.log('Actualizando fotos del usuario');
    try {
  
        let previousWorkers = '';
      
        await business.findById(req.body.businessId)
            .then((docs) => {
                previousWorkers = docs.workers;
        });
        item = JSON.parse(JSON.stringify(previousWorkers));
        item.push(req.body.workerId);
        const modificaciones = {workers: item};
        let resultado = await business.findByIdAndUpdate(req.body.businessId,{$set:modificaciones});
        res.status(200).json({message: 'Negocio Actualizado'});

        
    } catch (error) {
        res.status(500).json({error: error.message});
    };


}

async function updateWorkers(req,res){
    console.log('Actualizando trabajadores del usuario');
    let item = [];
    let previousWorkers = '';
      
        await business.findById(req.body.idBusiness)
            .then((docs) => {
                previousWorkers = docs.workers;
        
        });
         item = JSON.parse(JSON.stringify(previousWorkers));

        const filtro = req.body.idWorker;
        const setWorker = new Set(item);
        setWorker.delete(filtro);
        const arrayWorker = Array.from(setWorker);

        const modificaciones = {workers: arrayWorker};
        //console.log('Si prro');
        let resultado = await business.findByIdAndUpdate(req.body.idBusiness,{$set:modificaciones});
        console.log(resultado);
        return res.status(200).send('Todo ok');
}

async function updateArrayServices(req,res){
    let item = [];

   let previousService = '';


   await business.findById(req.body.idBusiness)
   .then((docs) => {

       previousService = docs.servicios;
       
       
   });

    item = JSON.parse(JSON.stringify(previousService));
    item.push(req.body.idService);

  
    const modificaciones = {servicios: item}

    let resultado = await business.findByIdAndUpdate(req.body.idBusiness,{$set: modificaciones});

    console.log(resultado);
    return res.status(200).send('Todo Ok');

}

async function updateBusiness(req,res){

    let businessId = req.body.idBusiness;

    const modificaciones = {
        businessName: req.body.businessName,
        category: req.body.category,
        email: req.body.email,
        contactNumber: req.body.contactNumber,
        direction: req.body.direction,
        latitude: req.body.latitude,
        longitude: req.body.longitude,
        description: req.body.description,
        horario: req.body.horario}

    await business.findByIdAndUpdate(businessId,{$set:modificaciones},(err,negocioUpdated)=>{
        
        if(err) {return res.status(404).json('Errosillo');}

        
        return res.status(200).json({business: negocioUpdated});

    })



}


async function getFavBusiness(req,res){
    


    await usuario.findById(req.body.idBusiness)
    .then(async(docs)=>{

        return res.status(200).json(docs.favoriteBusiness)
    
    })


}

//Exportar funciones
module.exports = {
    getAllBusiness,
    getOwnerBusiness,
    postBusiness,
    verifyOwnerBusiness,
    deleteBusiness,
    updateWorkersInBusinessbyCreateWorker,
    updateWorkers,
    updateArrayServices,
    updateBusiness,
    getFavBusiness
}