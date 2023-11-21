const {Schema, model} = require('mongoose')

//Datos que se guardan en la BD
const userSchema = new Schema({

    googleId: {type: String, required: true},
    UserName: {type: String, required: true},
    EmailUser: {type: String, required: true, unique: true},
    avatar: {type: String, required: true}

});

module.exports = model('usuario',userSchema);