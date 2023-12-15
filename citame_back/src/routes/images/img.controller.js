const sharp = require('sharp');
const fs = require('fs').promises;
const fss = require('fs');
const Negocio = require('../../models/business.model');
const Imagen = require('../../models/image.model');
const Trabajador = require('../../models/worker.model');


async function uploadImage(req,res){

    try {

        const bufferImg = await sharp(req.file.buffer).resize({width:300,height:300}).toBuffer();

        const nameFile = `img_${Date.now()}.png`;
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

        let idImagen = req.get('id');
        
        await Imagen.findById(idImagen).then((docs)=>{
            const rutaAlmacenamiento = docs.imgRuta;
            const dir = __dirname.substring(0,__dirname.length-17)
            const ruta = dir + rutaAlmacenamiento;
            const file = fss.readFileSync(ruta);
           // const base64String = Buffer.from(file).toString('base64');
            res.status(200).json(file);
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