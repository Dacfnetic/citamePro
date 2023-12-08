//Importación de paquetes requeridos
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
//Importación de enrutadores
const usersRouter = require('./routes/users/users.router.js');
const businessRouter = require('./routes/business/business.router.js');
const workersRouter = require('./routes/business/worker.router.js')
//Creación de aplicación express
const app = express();
//Informacion del servidor
app.use(cors());
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true, parameterLimit: 50000 }));
app.use(usersRouter);
app.use(businessRouter);
app.use(workersRouter);
//Exportación de aplicación express
module.exports = app;