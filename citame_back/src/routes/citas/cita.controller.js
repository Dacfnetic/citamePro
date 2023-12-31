
const citaModel = require('../../models/cita.model');
const workerModel = require('../../models/worker.model');
const business = require('../../models/business.model');
const Agenda = require('../../models/agenda');
//import { Agenda } from ('../../models/agenda');

async function getCita(req,res){
    
    try{
        citaModel.findById({idCita: req.get('_id') })
            .then(async(docs)=>{
                if(docs.idCita == req.get('_id')){
                    const allDates = '';
                    return res.status(200).json(allDates);
                }
            }).catch(e=>console.log(e));
    }catch(e){
        return res.status(404).json('Errosillo');
    }  
    

}

async function postCita(req,res){

    try{
            
               const dateCreated = await citaModel.create({
                    creadaBy:  req.body._idCliente ,
                    recibidaPor: req.body._idWorker ,
                    descripcionCita: req.body.descripcionCita,
                    citaHorario: req.body.citaHorario,
                    statusCita: 'Pendiente',
                    servicios: req.body.servicios
                });

                dateCreated.save();

                
                await workerModel.findByIdAndUpdate(req.body._idWorker,{ $push: {citasHechas: dateCreated} });


                //Manipular agenda con horario cita y devolver horario disponible

                let agenda = new Agenda(horario);

                await workerModel.findById(_idWorker).then((docs)=>{

                    agenda = docs.horarioDisponible
                
                    agenda.updateWorkerHorario(req.body.citaHorario)
                    

                })


                await workerModel.findByIdAndUpdate(req.body._idWorker,{ $set: {horarioDisponible: agenda} });



                return res.status(201).send({'sms':'cita creada'});
            
            
        
    }catch(e){
        return res.status(404).json('Errosillo');
    }  


}

async function deleteCita(req,res){

    try{
        await citaModel.findByIdAndDelete(req.body.idCita);
        return res.status(200).json({message: 'TodoOk'});
    
    }catch(e){
        return res.status(404).json({message: 'No se puede borrar la cita'});
    }


}

async function updateCita(req,res){

    let citaId = req.body.idCita;

    const citaUpdate = {
        creadaBy:  req.body._idCliente ,
        recibidaPor: req.body._idWorker ,
        descripcionCita: req.body.descripcionCita,
        citaHorario: req.body.citaHorario,
        statusCita: req.body.statusCita,
        servicios: req.body.servicios
    }
    
    await citaModel.findByIdAndUpdate(citaId, {$set: citaUpdate}, (err,citaUpdate)=>{

        if(err){
            return res.status(404).json('Error');
        }

        return res.status(200).json({citaModel: citaUpdate})

    });
}


module.exports = {
    deleteCita,
    updateCita,
    postCita,
    getCita
}