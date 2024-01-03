const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

//Datos que se guardan en la BD
const citaSchema = new Schema({

    creadaBy:{type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    recibidaPor: {type:mongoose.Schema.Types.ObjectId, ref:'worker'},
    descripcionCita: {type: String, required: true},
    fecha: {type: Date},
    hora:{type:String, required:true},
    estado:{type:String,required:true},
    servicios:[{type:mongoose.Schema.ObjectId, ref:'services',required:true}]
    
});

module.exports = model('cita',citaSchema);