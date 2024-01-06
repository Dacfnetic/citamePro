const {Schema, model} = require('mongoose');
const mongoose = require('mongoose');

const horasWorker = new mongoose.Schema({
    start: Date,
    end: Date
  
});

module.exports = model('horasworker',horasWorker);