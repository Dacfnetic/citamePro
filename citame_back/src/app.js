const express = require('express');
const morgan = require('morgan');
const app = express();
const cors = require('cors');

//Informacion del servidor
app.use(express.json());
app.use(morgan('dev'));

app.use(cors());

app.use(require('./routes/negocios'));

module.exports = app;