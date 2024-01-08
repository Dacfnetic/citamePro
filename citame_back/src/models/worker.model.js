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
  horario: {

      lunes: {
          start: { type: Date },
          end: { type: Date },
        },
      martes: {
          start: { type: Date },
          end: { type: Date },
        },
      miercoles: {
          start: { type: Date },
          end: { type: Date },
        },
      jueves: {
          start: { type: Date },
          end: { type: Date },
        },
      viernes: {
          start: { type: Date },
          end: { type: Date },
        },
      sabado: {
          start: { type: Date },
          end: { type: Date },
        },
      domingo: {
          start: { type: Date },
          end: { type: Date },
        },

  },

  horarioLibre: [{
      
      start: { type: Date },
      end: { type: Date },
      
  }],
  citasHechas:[{type: mongoose.Schema.Types.ObjectId, ref: 'cita'}],//Guardar el objeto de las citas
  serviciosWorker: [{type: mongoose.Schema.Types.ObjectId, ref: 'services'}]


});

module.exports = model('worker',workerSchema);

