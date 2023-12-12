const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

//Datos que se guardan en la BD
const workerSchema = new Schema({
    id: {type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    name: {type: String, required: true},
    email: {type: String, required: true},
    imgPath:[Number],
    salary :{type: Number},
    horario: {type: String},
    status: {type: Boolean},
    puesto: {type:String}
});

module.exports = model('worker',workerSchema);