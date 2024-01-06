const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');
const citaModel = require('./cita.model');

//Datos que se guardan en la BD
const workerSchema = new Schema({
    id: {type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    workwith: {type:mongoose.Schema.Types.ObjectId, ref:'business',required:true},
    name: {type: String, required: true},
    email: {type: String, required: true},
    imgPath:[{type:Schema.Types.ObjectId,ref:'Imagen'}],
    salary :{type: Number},
    puesto: {type:String},
    disponibilidad: [{type:mongoose.Schema.Types.ObjectId, ref: 'horasworker'}],
    citasHechas:[{type: mongoose.Schema.Types.ObjectId, ref: 'cita',required:true}],//Guardar el objeto de las citas
    serviciosWorker: [{type: mongoose.Schema.Types.ObjectId, ref: 'services'}]


});

module.exports = model('worker',workerSchema);

