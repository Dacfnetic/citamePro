//Importación de paquetes requeridos
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
//Importación de enrutadores
const usersRouter = require('./routes/users/users.router.js');
const businessRouter = require('./routes/business/business.router.js');
const workersRouter = require('./routes/workers/worker.router.js');
const servicesRouter = require('./routes/services/services.router.js');
const imgRouter = require('./routes/images/img.router.js');
//Creación de aplicación express
const app = express();
//Informacion del servidor
app.use(cors());
app.use(bodyParser.json({ limit: "500mb" }));
app.use(bodyParser.urlencoded({ limit: "500mb", extended: true, parameterLimit: 500000 }));
app.use(usersRouter);
app.use(businessRouter);
app.use(workersRouter);
app.use(imgRouter);
//app.use(servicesRouter);
//Exportación de aplicación express
module.exports = app;