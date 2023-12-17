const http = require('http');
const app = require('./src/app')
const WebSocket = require('ws');

const { connect } = require('./src/config/database');
//const {setupWebSocket} = require('./src/routes/notification/notification.controller');

const server = http.createServer(app);
const wss = new WebSocket.Server({noServer:true});
const PORT =  4000;

//Configuracion del WS, llamada desde el controller
//setupWebSocket(wss);


app.get('/',(req,res)=>{

    res.send('Hola Mijo');

});



async function main(){

    wss.on('connection', ws => {
        
        console.log('Client connected');
        ws.on('message', message => {
          console.log(`Mensaje recibido: ${message}`);
        });
        ws.send('Hello from WebSocket server');
      });
     

      server.on('upgrade', (request, socket, head) => {
        wss.handleUpgrade(request, socket, head, ws => {
          wss.emit('connection', ws, request);
        });
      });


    //Conexion a la BD
    await connect();

    //Express app
    await server.listen(PORT, () =>{
        console.log(`Server is running at port: ${PORT}`);
    });



    
    //WebSocketServer
    /*
    const wss = new WebSocket.WebSocketServer({noServer: true});

    wss.on('connection', ws)

    
    //Estamos en el http handler
    server.on('upgrade',(req,socket,head)=>{
        socket.on('error',onSocketPreError);

        //Autorizacion

        if(!!req.headers['NoAuth']){

            //No posee acceso
            socket.write('HTTP acceso no autorizado');
            socket.destroy();
            return;

        }

        //Posee acceso

        wss.handleUpgrade(req,socket,head, (ws)=>{
            socket.removeListener('error',onSocketPreError);
            wss.emit('connection',ws,req);

        });


    });

    //Pasamos el handler http
    wss.on('connection',(ws,req)=>{
        ws.on('error',onSocketPostError);

        ws.on('message', (msg,isBinary)=>{

            //Todos los clientes conectados
            wss.clients.forEach((client)=>{

                if(client.readyState === WebSocket.OPEN){
                    client.send(msg, {binary: isBinary});
                }


            });

        });


        ws.on('close',()=>{
            console.log('Conexion cerrada');
        });

    });*/

}

main();