const http = require('http');
const app = require('./src/app')
const WebSocket = require('ws');

const { connect } = require('./src/config/database');
const {setupWebSocket} = require('./src/routes/notification/notification.controller')

const server = http.createServer(app);
const wss = new WebSocket.Server({server})
const PORT = process.env.PORT || 4000;

//Configuracion del WS, llamada desde el controller
setupWebSocket(wss);


async function main(){

    //Conexion a la BD
    await connect();

    //Express app
    await server.listen(PORT, () =>{
        console.log(`Server is running at port: ${PORT}`);
    });
}

main();