const express = require('express');
//Importación de funciones
const { pagesUsuario,getPrivateInfo,getPublicInfo } = require('./auth.controller');
const verifyToken = require('../Auth/verifyToken')
//Creación de enrutador
const authRouter = express.Router();
//Asignación de direcciones

authRouter.get('/api/authUser/user',verifyToken,pagesUsuario);

//Exportar enrutador
module.exports = authRouter;