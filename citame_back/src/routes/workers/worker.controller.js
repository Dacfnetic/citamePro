//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const workersModel = require('../../models/worker.model.js');

async function postWorkers(req,res){
    try{       
        let existe = true;
        let worker = [];  
        await business.findOne({businessName: req.body.businessName, email: req.body.businessEmail})
            .then((docs) => {
                if(docs != null){
                    worker = JSON.parse(JSON.stringify(docs.workers)); //id mongo 
        }});
        let contador = 0;
       
        

        if(worker.length == 0){
            await usuario.findOne({emailUser: req.body.email})
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
                return res.status(202).send('Correo no registrado');
            });
        }


        if(worker.length != 0){
            await worker.forEach(async (e)=> {
                await workersModel.findOne({id : e}).then(async (docs) =>{
                    console.log(docs.email);
                    if(docs.email == req.body.email){
                        return res.status(203).send('El trabajador ya esta en el negocio');
                    }
                    contador += 1;
                    if(contador == worker.length){
                        await usuario.findOne({emailUser: req.body.email})
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
                return res.status(202).send('Correo no registrado');
                });
    
                }
                });           
            });   
        }
                   

        
    }catch(e){
        return res.status(404).json('Error Catastrofico, no se que paso');
    }; 

}

async function getWorkers(req,res){

    try{

        let worker = [];
        await business.findOne({businessName: req.get('businessName'), email: req.get('businessEmail')})
        .then((docs) => {
            if(docs != null){
                worker = JSON.parse(JSON.stringify(docs.workers)); //id mongo 
            }else{
                return res.status(201).send('No hay trabajadores');
            }
        });

        
        let trabajadores = []
        let contador = 0;

        worker.forEach(async (e)=> {

            const trabajador = await workersModel.findOne({id : e});

            trabajadores.push(trabajador);

            contador += 1;
            if(contador == worker.length){
                return res.status(200).json(trabajadores);
            }

    
        });
                            
        if(worker.length == 0) {
            return res.status(201).send('No hay trabajadores');
        }


    }catch(e){

        return res.status(404).json('Errorsillo');

    }

}

async function deleteWorkers(req,res){

    try {
        
        
        //Borrar modelo
        await workersModel.findByIdAndDelete(req.body.idWorker);
        return res.status(200).json({message: 'Todo ok'});


    } catch (e) {
        return res.status(404).json('Error Catastrofico, no se que paso');
    }




}

module.exports  = {

    getWorkers,
    postWorkers,
    deleteWorkers

}
