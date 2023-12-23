const express = require('express');
//Importación de funciones
const { authWithToken,getPrivateInfo,getPublicInfo } = require('./auth.controller');
//Creación de enrutador
const authRouter = express.Router();
//Asignación de direcciones

//Exportar enrutador
module.exports = authRouter;