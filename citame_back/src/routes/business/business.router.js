const express = require('express');
//Importación de funciones
const { getAllBusiness,getOwnerBusiness, postBusiness, verifyOwnerBusiness, deleteBusiness, updateBusiness,updateWorkers } = require('./business.controller.js');
//Creación de enrutador
const businessRouter = express.Router();
//Asignación de direcciones
businessRouter.get('/api/business/get/all',getAllBusiness);
businessRouter.get('/api/business/get/owner',getOwnerBusiness);
businessRouter.post('/api/business/create',postBusiness);
businessRouter.post('/api/business/verify/owner/business',verifyOwnerBusiness);
businessRouter.delete('/api/business/delete',deleteBusiness);
businessRouter.put('/api/business/update',updateBusiness);
businessRouter.put('/api/business/workerupdate',updateWorkers);

//Exportar enrutador
module.exports = businessRouter;