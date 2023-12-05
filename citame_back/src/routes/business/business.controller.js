//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');

async function getAllBusiness(req,res){
    try{
        usuario.findOne({emailUser: req.get('email')})
            .then(async(docs)=>{
                if(docs.emailUser == req.get('email')){
                    const allBusiness = await business.find();
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
                    
                    if(req.get('estado')=='1'){
                        return res.status(201).send('1');
                    }
                    return res.status(200).json(ownerBusiness);
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
                    listaDeNombres = ownerBusiness.map((busi)=> busi.businessName);
                    listaDeNombresOrdenada = listaDeNombres.sort(function(a, b){return b - a});
                    listaRecibidaOrdenada = req.get('nombres').sort(function(a, b){return b - a});
                    if(listaRecibidaOrdenada==listaDeNombresOrdenada){
                        return res.status(200).send('1');
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
                });
                return res.status(201).send("Negocio creado");
        });
    }catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }  
}
//Exportar funciones
module.exports = {
    getAllBusiness,
    getOwnerBusiness,
    postBusiness,
    verifyOwnerBusiness
}