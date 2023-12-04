//Importación de paquetes requeridos
const express = require('express');
const cors = require('cors');
//Importación de enrutadores
const usersRouter = require('./routes/users/users.router.js');
const businessRouter = require('./routes/business/business.router.js');
//Creación de aplicación express
const app = express();
//Informacion del servidor
app.use(cors());
app.use(express.json());
app.use(usersRouter);
app.use(businessRouter);
//Exportación de aplicación express
module.exports = app;