
let diasConCitas = [];
let lun = [];
let ma = [];
let mie = [];
let jue = [];
let vie = [];
let sab = [];
let dom = [];


class Agenda {
    constructor(horario){
        const horarioJson = JSON.parse(horario);
        lun = horarioJson.lunes.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });
        ma = horarioJson.martes.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });
        mie = horarioJson.miercoles.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });
        jue = horarioJson.jueves.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });
        vie = horarioJson.viernes.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });
        sab = horarioJson.sabado.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });
        dom = horarioJson.domingo.map((h) => {
            const hinicial = new Date(2020,1,2,h.hora_inicial,h.minuto_inicial);
            const hfinal = new Date(2020,1,2,h.hora_final,h.minuto_final);
            return {'HoraInicial': hinicial, 'HoraFinal': hfinal};
        });

    }


    agregarDiaNoDisponible(dia){
        this.diaNoDisponible.push(dia);
    }

    //Metodo restar cita para horario disponible

    updateWorkerHorario(citaJson){

        const cita = JSON.parse(citaJson);
        const fecha = `${cita.dia}/${cita.mes}/${cita.year}`
        const index = diasConCitas.findIndex((fecha)=> fecha.Fecha === fecha)

        
        if(index === -1){
            
            let fechaFront = new Date(cita.year,cita.mes,cita.dia);
            fechaFront.getDay();
            fechaFront.getHours();


            const dia = fechaFront.getDay(); //obtener fecha con getDate
            let horarioD;

            switch (dia) {

                    case 1: 

                    horarioD = lun;

                    break;

                    case 2: 

                    horarioD = ma;

                    break;

                    case 3: 

                    horarioD = mie;

                    break;
                    case 4: 

                    horarioD = jue;

                    break;
                    case 5: 

                    horarioD = vie;

                    break;
                    case 6: 

                    horarioD = sab;

                    break;
                    case 0: 

                    horarioD = dom;

                    break;
            
                default:
                    break;
            }

            
            diasConCitas.push({'Fecha':fecha,'HorarioDisp': horarioD });

        }else{
            
            const horaInicio = new Date(2020,1,2,cita.hora_inicial,cita.minuto_inicial,0);
            const horaFinal = new Date(2020,1,2,cita.hora_final,cita.minuto_final,0);
            const indexH = diasConCitas[index].HorarioDisp.findIndex((horaD)=>  horaD.horaInicio.getHours() <= horaInicio.getHours() && horaD.horaFinal.getHours() >= horaFinal.getHours())  

            const horario1A = new Date (2020,1,2,diasConCitas[index].HorarioDisp[indexH].horaInicio.getHours(),diasConCitas[index].HorarioDisp[indexH].horaInicio.getMinutes()) ;
            const horario2A = new Date (2020,1,2,horaInicio.getHours(),horaInicio.getMinutes());

            const horarioA = {'HoraInicial':horario1A,'HoraFinal' : horario2A};


            const horario1B = new Date (2020,1,2,horaFinal.getHours(),horaFinal.getMinutes());
            const horario2B = new Date (2020,1,2,diasConCitas[index].HorarioDisp[indexH].horaFinal.getHours(),diasConCitas[index].HorarioDisp[indexH].horaFinal.getMinutes()) ;

            const horarioB = {'HoraInicial':horario1B,'HoraFinal' : horario2B};




           // if (horarioinicial del indice del horario disponible es menor que el horario de inicio && el horario final del indice del horario disponible es mayor que el horario final){

            diasConCitas[index].HorarioDisp.splice(indexH,1,horarioA,horarioB);
        

        }

    }




}


module.exports = {
    Agenda
}