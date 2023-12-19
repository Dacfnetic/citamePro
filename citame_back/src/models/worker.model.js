const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');
const citaModel = require('./cita.model');

//Datos que se guardan en la BD
const workerSchema = new Schema({
    id: {type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    name: {type: String, required: true},
    email: {type: String, required: true},
    imgPath:[{type:Schema.Types.ObjectId,ref:'Imagen'}],
    salary :{type: Number},
    horario: {type: String},
    status: {type: Boolean},
    puesto: {type:String},
    horarioCita:[{type: mongoose.Schema.Types.ObjectId,ref:'cita'}]
});

module.exports = model('worker',workerSchema);