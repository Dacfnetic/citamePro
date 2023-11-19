const {Schema, model} = require('mongoose')

//Datos que se guardan en la BD
const userSchema = new Schema({

    googleId: String,
    UserName: String,
    EmailUser: String,
    avatar: String

});

module.exports = model('usuario',userSchema);