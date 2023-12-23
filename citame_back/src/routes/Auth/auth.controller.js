const usuario = require('../../models/users.model');
const bussiness = require('../../models/business.model');
const jwt = require('jsonwebtoken');

//Acceso al token
async function authWithToken(req,res){
    
    const token = null;

}

async function getPublicInfo(req,res,next){


}

async function getPrivateInfo(req,res,next){

}






module.exports = {

    authWithToken,
    getPrivateInfo,
    getPublicInfo,

}