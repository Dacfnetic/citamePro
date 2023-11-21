const app = require('./app')
const port = 4000;
const { connect } = require('./config/database')

async function main(){

    //Conexion a la BD

    await connect();

    //Express app
    await app.listen(port);
    console.log(`Puerto ${port} activado...`)

}

main();