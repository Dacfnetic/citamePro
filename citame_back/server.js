const http = require('http');
const app = require('./src/app')
const { Server } = require("socket.io");
const { join } = require('node:path');

const { connect } = require('./src/config/database');
const {setupWebSocket} = require('./src/routes/notification/notification.controller')

const server = http.createServer(app);
const io = new Server(server);
const PORT = process.env.PORT || 5000;

//Configuracion del WS, llamada desde el controller



async function main(){

    //Conexion a la BD
    await connect();


    app.get('/', (req, res) => {
        res.sendFile(join(__dirname, 'index.html'));
      });

      io.on('connection', (socket) => {
        console.log('a user connected');
      });
    //Express app
    await server.listen(PORT, () =>{
        console.log(`Server is running at port: ${PORT}`);
    });
}

main();