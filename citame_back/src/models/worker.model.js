const {Schema, model} = require('mongoose')

//Datos que se guardan en la BD
const workerSchema = new Schema({
    name: {type: String, required: true},
    email: {type:mongoose.Schema.Types.ObjectId, ref:'usuario',required:true},
    imgPath:[Number],
    salary :{type: Number},
    horario: {type: String},
    status: {type: Boolean}
});

module.exports = model('worker',workerSchema);