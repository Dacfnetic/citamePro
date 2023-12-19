const express = require('express');
//Importación de funciones
const { postCita} = require('./cita.controller');
//Crear enrutador
const citaRouter = express.Router();
//Asignación de direcciones
citaRouter.post('/api/workers/create',postCita);

//workersRouter.put('/api/workers/updateHorario',updateHorario);
//Exportar enrutador
module.exports = citaRouter;