const usuario = require('../../models/users.model')
const citaModel = require('../../models/cita.model');
const workerModel = require('../../models/worker.model');
const business = require('../../models/business.model');
const jwt = require('jsonwebtoken');

const Agenda = require('../../models/agenda');
const config = require('../../config/configjson.js');

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

async function postCita3(req,res){

    const token = req.headers['x-access-token'];//Buscar en los headers que me tienes que mandar, se tiene que llamar asi para que la reciba aca

        if(!token){
            return res.status(401).json({
                auth: false,
                message: 'No token'
            });
        }
        //Una vez exista el JWT lo decodifica
        const decoded =  jwt.verify(token,config.jwtSecret);//Verifico en base al token


    const user = decoded.idUser;
    const worker = req.body.workerId;
    const fecha = req.body.fecha;
    const horaInicio = req.body.horaInicio;
    const duracion = req.body.duracion;
    const servicio = req.body.servicioId;

    const fechaY = fecha.split("T")[0];

    const workerFind = await workerModel.findOne({  _id: worker });

    //Si el worker no existe
    if (!workerFind) {
        res.status(404).json({
          success: false,
          message: "El worker no existe",
        });
        return;
      }


    const horario = workerFind.horario[fechaY];

    //Si el horario no esta disponible
    if (!horario) {
        res.status(404).json({
          success: false,
          message: "El worker no está disponible en esa fecha",
        });
        return;
      }

      //Buscar el intervalo disponible
      const intervalo = horario.find((intervalo) => intervalo.horaInicio <= horaInicio && horaInicio < intervalo.horaFin);

      if(intervalo){

        const cita = new Cita({

            user,
            worker,
            fecha,
            horaInicio,
            servicio,
            duracion,
        
        });

        await cita.save();

        res.status(400).json({
            success: true,
            message: 'Cita creada'
        })

    }

    res.status(400).json({
        success: false,
        message: 'El intervalo de hora no esta disponible'
    })

}

async function postCita(req,res){

    try{

        const token = req.headers['x-access-token'];//Buscar en los headers que me tienes que mandar, se tiene que llamar asi para que la reciba aca

        if(!token){
            return res.status(401).json({
                auth: false,
                message: 'No token'
            });
        }
        //Una vez exista el JWT lo decodifica
        const decoded =  jwt.verify(token,config.jwtSecret);//Verifico en base al token
    
                const cita = req.body.cita;
                const dateCreated = new citaModel({
                    creadaBy:  decoded.idUser,
                    recibidaPor: req.body.idWorker ,
                    //descripcionCita: req.body.descripcionCita,
                    citaHorario: cita,
                    statusCita: 'Pendiente',
                    servicios: req.body.servicios
                });

                
                const trabajador = await workerModel.findById(req.body.idWorker);
                
                


                //Manipular agenda con horario cita y devolver horario disponible

                let agenda = new Agenda();
                agenda.establecerHorarios(trabajador._doc.horarioDisponible);
                const funciona = agenda.updateWorkerHorario(cita);

                if(funciona){
                    dateCreated.save();
                    await workerModel.findByIdAndUpdate(req.body.idWorker,{$push: {citasHechas: dateCreated}});
                    await workerModel.findByIdAndUpdate(req.body.idWorker,{$set: {horarioDisponible: agenda}});

                    return res.status(201).send('Todo ok');
                }else{
                    return res.status(202).send('Mal, muy mal');
                }   
    }catch(e){
        return res.status(404).json('Errosillo');
    };  


}*/

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
        
        //Comentar acerca de que pasaria si un usuario quiere escoger otro worker
        fecha: req.body.fecha,
        hora: req.body.hora,
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