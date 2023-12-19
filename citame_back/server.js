const http = require('http');
const app = require('./src/app')
const { Server } = require("socket.io");


const { connect } = require('./src/config/database');
//const {setupWebSocket} = require('./src/routes/notification/notification.controller');

const server = http.createServer(app);
const io = new Server(server);
const PORT = process.env.PORT || 4000;


async function main(){

    //Conexion a la BD
    await connect();


    app.get('/', (req, res) => {
        res.send('Holis');
      });

    io.on('connection', (socket) => {
        console.log('a user connected');
        console.log(socket.id,"has joined");
        socket.on("/test",(msg)=>{
            console.log(msg);
        });       
    });

 

    


    //Express app
    await server.listen(PORT ,() =>{
        console.log(`Server is running at port: ${PORT}`);
    });


}
main();