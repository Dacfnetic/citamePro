const express = require('express');
//Importación de funciones
const { getUser, postUser, serverReady } = require('./users.controller.js');
//Crear enrutador
const usersRouter = express.Router();
//Asignación de direcciones
usersRouter.get('/',serverReady);
usersRouter.get('/api/user/get',getUser);
usersRouter.post('/api/user/create',postUser);
//Exportar enrutador
module.exports = usersRouter;