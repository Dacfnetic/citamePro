const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

//Datos que se guardan en la BD
const citaSchema = new Schema({

    creadaBy:{type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    recibidaPor: {type:mongoose.Schema.Types.ObjectId, ref:'worker'},
    fechaInicio: {type: Date},
    fechaFinal: {type: Date},
    estado:{type:String,required:true},
    servicios:[{type:mongoose.Schema.ObjectId, ref:'services',required:true}],
    duracion:{type:Number,required:true},
    
});

module.exports = model('cita',citaSchema);