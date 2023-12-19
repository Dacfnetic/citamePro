const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

//Datos que se guardan en la BD
const citaSchema = new Schema({

    creadaBy:{type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    descripcionCita: {type: String, required: true},
    citaHorario:{type:String, required:true},
    statusCita:{type:Boolean}
    
});

module.exports = model('cita',citaSchema);