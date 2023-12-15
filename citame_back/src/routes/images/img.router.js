const express = require('express');
const imgController = require('../images/img.controller');
const uploadMiddleware = require('../middlewares/uploadMiddleware');

const imgRouter = express.Router();

imgRouter.post('/api/imagen/upload',uploadMiddleware.single('imagen'),imgController.uploadImage);
imgRouter.get('/api/imagen/download',imgController.downloadImage);


module.exports = imgRouter;