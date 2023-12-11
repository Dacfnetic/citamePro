//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const workersModel = require('../../models/worker.model.js');

async function postWorkers(req,res){
    try{       
        
        let worker = [];  
        await business.findOne({businessName: req.body.businessName, email: req.body.email})
            .then((docs) => {
                if(docs != null){
                    worker = JSON.parse(JSON.stringify(docs.workersModel)); //id mongo 
        }});
        
        const workersEmail = worker.map(async (e)=>{ 
                
            await workersModel.find({id : e}).then((docs) =>{
                    return docs.email;
                });
              
            
            })
        const workerExist = workersEmail.has(req.body.email);


        if (workerExist == true){
            return res.status(202).send('El trabajador ya esta en el negocio');
        }

        usuario.findOne({emailUser: req.body.email})
         .then(async (docs)=>{
            if(docs != null){
                console.log('Creando Trabajador');
                await workersModel.create({
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
               
            });

        }
        
    }catch(e){
        return res.status(404).json('Errosillo');
    }; 

}

async function deleteWorkers(req,res){




}

module.exports  = {

    postWorkers,
    deleteWorkers

}
