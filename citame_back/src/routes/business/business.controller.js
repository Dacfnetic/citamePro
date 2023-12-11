//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');


async function getAllBusiness(req,res){
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
        usuario.findOne({emailUser: req.get('email')})
            .then(async(docs)=>{
                if(docs.emailUser == req.get('email')){
                    const ownerBusiness = await business.find({ createdBy: docs._id });
                    const comprob =req.get('estado');
                    if(comprob=='1'){
                        return res.status(200).send('1');
                    }
                    return res.status(201).json(ownerBusiness);
                }
            }).catch(e=>console.log(e));
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
}
async function verifyOwnerBusiness(req,res){
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

                const img64 = req.body.imgPath;// x64
                const imgReady = '';

                await business.create({
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
                    imgPath: req.body.imgPath,
                    horario: req.body.horario,
                    servicios: req.body.servicios
                });
                return res.status(201).send("Negocio creado");
        });
    }catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }  
}
async function deleteBusiness(req,res){
    try{
        let existe = true;    
        await business.findOneAndDelete({businessName: req.body.businessName, email: req.body.email})
        return res.status(200).json({message: 'Todo ok'});
    }catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }  
}
async function updateBusiness(req,res){

    try {
  
        //Diego envia el email del trabador por el body

        //Tenemos que encontrar el idmongo de ese email
        let idMongo = '';

        await usuario.findOne({emailUser: req.body.workerEmail})
        .then((docs)=>{
            if(docs != null){
               idMongo = docs._id.toString();
            }
        });
    
        //Encontrar los workers que ya existen
        let previousWorkers = '';
        let bId = '';
        await business.findOne({businessName: req.body.businessName, email: req.body.email})
            .then((docs) => {
                previousWorkers = docs.workers;
                bId = docs._id.toString();
                console.log(docs);
        });
        item = JSON.parse(JSON.stringify(previousWorkers));
        item.push(idMongo);
        const modificaciones = {workers: item};
        console.log('Si prro');
        let resultado = await business.findByIdAndUpdate(bId,{$set:modificaciones});
        //await business.findOneAndUpdate(businessSearch,{$set:{workers: item}},{new: true});
        console.log(resultado);
        res.status(200).json({message: 'Negocio Actualizado'});
        
        

    } catch (error) {
        res.status(500).json({error: error.message});
    };


}



//Exportar funciones
module.exports = {
    getAllBusiness,
    getOwnerBusiness,
    postBusiness,
    verifyOwnerBusiness,
    deleteBusiness,
    updateBusiness
}