const http = require('http');
const app = require('./src/app')
const { Server } = require("socket.io");
const user = require('./src/models/users.model');

const { connect } = require('./src/config/database');
const { setTimeout } = require('timers');
//const {setupWebSocket} = require('./src/routes/notification/notification.controller');

const server = http.createServer(app);
const io = new Server(server);
const PORT = process.env.PORT || 4000;
const usuariosConectados = new Set();

            
async function update(){
    await io.emit('CACA', 'CACA');
    setTimeout(update,5000);
}


async function main(){
    
    //Conexion a la BD
    await connect();
    app.get('/', (req, res) => {
        res.send('Holis');
      });
      //Usuarios conectados
      let contador = 0;
    io.on('connection', (socket) => {
        //io.disconnectSockets(true);
        console.log('a user connected' + socket.id);
        
        socket.on('UsuarioRegistrado',(emailUser) => {  
            contador++;
            console.log(contador);       
            if(usuariosConectados.has(emailUser)){
                socket.emit('Usuario encontrado');
                console.log(usuariosConectados);
            }else{
                usuariosConectados.add(emailUser);
                //Mandar los usuarios
                io.emit('Usuarios Actualizados', Array.from(usuariosConectados));


                console.log(usuariosConectados);
            } 
            update();



        });
     
        //Desconexion de usuarios
        socket.on('disconnect',()=>{
            console.log('usuario desconectado');
            usuariosConectados.delete(socket.emailUser);
            console.log(usuariosConectados);
            io.emit('Usuarios Actualizados',Array.from(usuariosConectados));
        })
    });

    //Express app
    await server.listen(PORT ,() =>{
        console.log(`Server is running at port: ${PORT}`);
    });

}

main();