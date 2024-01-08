//Importación de modelos de objetos
const usuario = require('../models/users.model.js')
const business = require('../models/business.model.js');
const services = require('../models/services.model.js');
const workerModel = require('../models/worker.model.js');
const Imagen = require('../models/image.model.js')
const fss = require('fs');
const horarioworker = require('../models/horarioworker.js');
const luxon = require('luxon');


async function deleteImagen(item){

    const deletedImages = await Promise.all(

        item.map(async (imagen)=>{

            const idImage = imagen;
            const deletedImage = await Imagen.findByIdAndDelete(idImage);

            if(!deletedImage){
                return null;
            }

            const rutaAlmacenamiento = deletedImage._doc.imgRuta;
            const dir = __dirname.substring(0,__dirname.length-10)
            const ruta = dir + rutaAlmacenamiento;
            fss.rmSync(ruta);
            return deletedImage;
        })

    );

        return deletedImages;

    
}

async function deleteImagesOnArrayWorkers(item){
    
    const arrayWorker = item.slice();

        const promiseWorker = arrayWorker.map(async(worker2)=>{
            
            const sworkerFind = await workerModel.findById(worker2);
            previousWorkerImage = sworkerFind.imgPath;
            await deleteImagen(previousWorkerImage);
            
        });

        await Promise.all(promiseWorker)
}

async function deleteImagesOnArrayService(item){

    const arrayServicios = item.slice();

        const promisesService = arrayServicios.map(async(servicio2)=>{
            
            const serviciotoFind = await services.findById(servicio2);
            previousServiceImage = serviciotoFind.imgPath;
            await deleteImagen(previousServiceImage);
            
        });

        await Promise.all(promisesService)

}

async function verifyDisponibilidad(worker, start, end){

    const horarioWorker = worker.horario;
    const hoy = new Date();
    const dia = hoy.getDay();

    const horaInicioWorker = horarioworker[dia].start;
    const horaFinalWorker = horarioworker[dia].end;

    const intervaloHorario = luxon.Interval.fromDateTimes(horaInicioWorker, horaFinalWorker);
    const intervaloDescanso = horarioWorker[dia].horarioLibre.map(libre => luxon.Interval.fromDateTimes(libre.start, libre.end));

    return intervaloHorario.contains(start) && intervaloHorario.contains(end) && intervaloDescanso.every(
        intervaloLibre => !intervaloLibre.contains(start) && !intervaloLibre.contains(end));


}


module.exports = {
    deleteImagesOnArrayWorkers,
    deleteImagesOnArrayService,
    deleteImagen,
    verifyDisponibilidad

}