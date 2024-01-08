const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

//Datos que se guardan en la BD
const citaSchema = new Schema({

    creadaBy:{type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    recibidaPor: {type:mongoose.Schema.Types.ObjectId, ref:'worker'},
    fechaInicio: {type: Date, required:true},
    fechaFinal: {type: Date, required:true},
    //estado:{type:String,required:true},
    servicios:[{type:mongoose.Schema.ObjectId, ref:'services',required:true}],
    duracion: {type: Number}
});

module.exports = model('cita',citaSchema);