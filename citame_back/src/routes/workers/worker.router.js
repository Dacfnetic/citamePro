const express = require('express');
//Importación de funciones
const { postWorkers, deleteWorkers} = require('./worker.controller');
//Crear enrutador
const workersRouter = express.Router();
//Asignación de direcciones
workersRouter.post('/api/workers/create',postWorkers);
workersRouter.delete('/api/workers/delete',deleteWorkers);
//Exportar enrutador
module.exports = workersRouter;