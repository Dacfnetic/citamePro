const http = require('http');
const app = require('./src/app')
const { Server } = require("socket.io");
const user = require('./src/models/users.model');


const { connect } = require('./src/config/database');
//const {setupWebSocket} = require('./src/routes/notification/notification.controller');

const server = http.createServer(app);
const io = new Server(server);
const PORT = process.env.PORT || 4000;
const usuariosConectados = new Set();


async function main(){

    //Conexion a la BD
    await connect();


    app.get('/', (req, res) => {
        res.send('Holis');
      });

      //Usuarios conectados
    io.on('connection', (socket) => {
        console.log('a user connected');
        
        socket.on('UsuarioRegistrado',(emailUser) => {         
                
                if(usuariosConectados.has(emailUser)){

                    socket.emit('Usuario encontrado');
                    console.log(usuariosConectados);

                }else{

                    //const userNew = new user({emailUser: emailUser});
                    //Guardarlos en el array
                   // userNew.save();
                    //socket.emailUser = emailUser;
                    usuariosConectados.add(emailUser);
                    //Mandar los usuarios
                    io.emit('Usuarios Actualizados', Array.from(usuariosConectados));


                }

   


        });

        //Desconexion de usuarios
        socket.on('disconnect',()=>{
            console.log('usuario desconectado');
            usuariosConectados.delete(socket.emailUser);
            io.emit('Usuarios Actualizados',Array.from(usuariosConectados));
        })

    });



 
    //Express app
    await server.listen(PORT ,() =>{
        console.log(`Server is running at port: ${PORT}`);
    });


}

main();