const {Schema, model} = require('mongoose')

//Datos que se guardan en la BD
const negocioSchema = new Schema({

    businessName: String,
    category: String,
    email: String,
    contactNumber: String,
    direction: String,
    latitude: String,
    longitude: String,
    description: String,

});

module.exports = model('negocio',negocioSchema);