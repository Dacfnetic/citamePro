const express = require('express');
//Importación de funciones
const { postWorkers} = require('./worker.controller');
//Crear enrutador
const workersRouter = express.Router();
//Asignación de direcciones
workersRouter.post('/api/workers/create',postWorkers);
//Exportar enrutador
module.exports = workersRouter;