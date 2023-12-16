const sharp = require('sharp');
const fs = require('fs').promises;
const fss = require('fs');
const Negocio = require('../../models/business.model');
const Imagen = require('../../models/image.model');
const Trabajador = require('../../models/worker.model');

function randomImageName(){
    const longitudName = 15;
    const diccionario = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    let randomName = '';

    for(let i = 0 ; i<longitudName; i++){
        const randomIndex = Math.floor(Math.random()*diccionario.length);
        randomName += diccionario.charAt(randomIndex);
    }

    return randomName;


}



async function uploadImage(req,res){

    try {

        const bufferImg = await sharp(req.file.buffer).resize({width:300,height:300}).toBuffer();

        const nameImg = randomImageName();
        const nameFile = `img_${nameImg}_${Date.now()}.png`;

        const rutaAlmacenamiento = `src/img_CitaMe/${nameFile}`;

        
        await fs.writeFile(rutaAlmacenamiento,bufferImg);

        const imagen = new Imagen({imgNombre:nameFile,imgRuta:rutaAlmacenamiento});
        await imagen.save();

        const id = req.body.id;
        if(req.body.destiny == 'business'){
            await Negocio.findByIdAndUpdate(id,{ $push: {imgPath: imagen._id} });
            res.status(201).send('Imagen Subida');
        }
        if(req.body.destiny == 'worker'){
            await Trabajador.findByIdAndUpdate(id,{ $push: {imgPath: imagen._id} });
            res.status(201).send('Imagen Subida');
        }
        

    } catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }


}

async function downloadImage(req,res){

    try {
        console.log('Te vamos a intentar enviar una imagen');
        let idImagen = req.get('id');
        
        await Imagen.findById(idImagen).then((docs)=>{
            console.log('Estamos intentado encontrar tu imagen');
            const rutaAlmacenamiento = docs.imgRuta;
            const dir = __dirname.substring(0,__dirname.length-17)
            const ruta = dir + rutaAlmacenamiento;
            console.log('La encontramos, la vamos a convertir a lista de enteros');
            const file = fss.readFileSync(ruta);
            const imagenConvertidad = JSON.stringify(file);
            //console.log(imagenConvertidad);
            console.log('Convertida, te la vamos a enviar');
            //console.log(file);
            return res.status(200).send(file);
        });
        
    } catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }


}



module.exports = {
    uploadImage,
    downloadImage
}