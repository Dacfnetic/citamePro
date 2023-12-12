const express = require('express');
//Importación de funciones
const { postWorkers,getWorkers,deleteWorkers} = require('./worker.controller');
//Crear enrutador
const workersRouter = express.Router();
//Asignación de direcciones
workersRouter.post('/api/workers/create',postWorkers);
workersRouter.get('/api/workers/get',getWorkers);
workersRouter.delete('/api/workers/delete',deleteWorkers);
//Exportar enrutador
module.exports = workersRouter;