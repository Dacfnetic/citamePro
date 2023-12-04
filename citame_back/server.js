const http = require('http');
const app = require('./src/app')

const { connect } = require('./src/config/database')

const server = http.createServer(app);

const PORT = process.env.PORT || 4000;

async function main(){

    //Conexion a la BD
    await connect();

    //Express app
    await server.listen(PORT, () =>{
        console.log(`Server is running at port: ${PORT}`);
    });
}

main();