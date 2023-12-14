const sharp = require('sharp');
const fs = require('fs').promises;
const Negocio = require('../../models/business.model');
const Imagen = require('../../models/image.model');


async function uploadImage(req,res){

    try {

        const bufferImg = await sharp(req.file.buffer).resize({width:req.body.imgWidth,height:req.body.imgHeight}).toBuffer();

        const nameFile = `img_${Date.now()}.png`;
        const rutaAlmacenamiento = `img_CitaMe/${nameFile}`;

        await fs.writeFile(rutaAlmacenamiento,bufferImg);

        const imagen = new Imagen({imgNombre:nameFile,imgRuta:rutaAlmacenamiento});
        await imagen.save();

        const idBusiness = req.body.idBusiness;
        await Negocio.findByIdAndUpdate(idBusiness,{ $push: {imgPath: imagen._id} });

        res.status(201).send('Imagen Subida ');

    } catch(e){
        console.log(e);
        return res.status(404).json('Errosillo');
    }


}

async function getImages(req,res){

    try {

    } catch (e) {
        return res.status(404).json('Error :(');
    }


}

module.exports = {
    uploadImage
}