const express = require('express');
//Importación de funciones
const { getAllBusiness,getOwnerBusiness, postBusiness } = require('./business.controller.js');
//Creación de enrutador
const businessRouter = express.Router();
//Asignación de direcciones
businessRouter.get('/api/business/get/all',getAllBusiness);
businessRouter.get('/api/business/get/owner',getOwnerBusiness);
businessRouter.post('/api/business/create',postBusiness);
//Exportar enrutador
module.exports = businessRouter;