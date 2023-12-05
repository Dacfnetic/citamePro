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
                    return res.status(200).json(ownerBusiness);
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
    postBusiness
}