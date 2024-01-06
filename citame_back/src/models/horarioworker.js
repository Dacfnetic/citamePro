const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

const horasWorker = new mongoose.Schema({
    horaInicio: Date,
    horaFinal: Date
});

module.exports = model('horasworker',horasWorker);