const usuario = require('../../models/users.model')
const citaModel = require('../../models/cita.model');
const workerModel = require('../../models/worker.model');
const business = require('../../models/business.model');
const jwt = require('jsonwebtoken');
const config = require('../../config/configjson.js');
const Agenda = require('../../models/agenda');
const {verifyDisponibilidad} = require('../../config/functions.js');
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
    const worker = await workerModel.findById(req.body.workerId);
    const services = req.body.servicioId;
    const start = new Date(req.body.horaInicio);
    const end = new Date(req.body.horaFinal);
    //Dia de la cita
    const dia = new Date().getDay();
    
    if(!verifyDisponibilidad(worker,start,end)){
        res.status(400).json({message: 'El trabajador no está disponible en ese horario',});
        return;
    }

    //Calculo de la hora de la cita

    const duracionCita = services.reduce( ( acc, service ) => acc + service.duracion, 0 );

    //Verificar si la cita no excede el horario del worker

    if(duracionCita > worker.horario[start.getDay()].end - start){

        res.status(400).json({message: 'La cita excede el horario disponible del trabajador',});
        return;

    }

    const cita = new Cita({

        creadaBy: user,
        recibidaPor: worker._id,
        fechaInicio: start,
        fechaFinal: end,
        servicios: services,
        duracion: duracionCita

    })

    await cita.save();

    worker.horario[start.getDay()].start = start;
    worker.horario[start.getDay()].end = end;
    await worker.save();

    res.status(200).json({message: 'cita creada con exito'});

}

/*async function postCita(req,res){

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
        const user = '';

        await usuario.findById(decoded.idUser)
        .then((docs)=>{

            user = docs._id;

        });

        //Usuario Actual

        // const user = await usuario.findOne({emailUser: req.body.emailUser});

        //Creacion de la cita
 
        const cita = new Cita({
            creadaBy: user,
            recibidaPor: req.body.worker,
            fecha: req.body.fecha,
            hora: req.body.horario,
        });

        //Verificar si la hora esta disponible

        const horaEnHorario = await workerModel.findOne(
            {
                _id: req.body.worker,
                horario: {
                  fecha: cita.fecha,
                  hora: cita.hora,
                },
              },
              {
                $set: {
                  estado: "reservada",
                },
              },
              {
                returnOriginal: true,
              }
            );
        
        //Si la hora no esta disponible mostrar error

        if(!horaEnHorario || horaEnHorario.horario.estado === 'reservada'){
            return res.status(400).send("La hora no esta disponible");
        }

        //Servicios Obtenidos

        const servicios = req.body.services;

        //Guardar la cita

        cita.save((err, cita)=>{

            if(err){
                return res.status(500).send(err)
            };

            //Guardar los servicios

            cita.servicios = servicios;
            cita.save((err, cita)=>{
                if(err){
                    return res.status(500).send(err);
                };

                return res.status(201).send(cita)
            });

        });
            
        
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