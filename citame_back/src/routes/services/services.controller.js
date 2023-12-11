//Importación de modelos de objetos
const usuario = require('../../models/users.model.js');
const business = require('../../models/business.model.js');
const services = require('../../models/services.model.js');

async function getServices(req,res){
    
}

async function postServices(req,res){

    try{
        



    }catch(e){
        return res.status(404).json('Errosillo');
    } 

};

async function deleteService(req,res){

};

async function updateService(req,res){

};

module.exports = {
    getServices,
    postServices,
    deleteService,
    updateService
}