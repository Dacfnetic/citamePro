import 'dart:developer';

import 'package:citame/models/business_model.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/user_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final myBusinessStateProvider =
    StateNotifierProvider<MyBusinessStateNotifier, List<Business>>((ref) {
  return MyBusinessStateNotifier();
});

class MyBusinessStateNotifier extends StateNotifier<List<Business>> {
  MyBusinessStateNotifier() : super([]);

  void setHorarioParaEnviar(Map entrada) {
    var contador = 0;
    workerDaysAvailableEnviar.clear();
    List datos = [];
    for (var horas in entrada['horario']['lunes']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['lunes'] = datos;
    datos = [];
    for (var horas in entrada['horario']['martes']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['martes'] = datos;
    datos = [];
    for (var horas in entrada['horario']['miercoles']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['miercoles'] = datos;
    datos = [];
    for (var horas in entrada['horario']['jueves']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['jueves'] = datos;
    datos = [];
    for (var horas in entrada['horario']['viernes']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['viernes'] = datos;
    datos = [];
    for (var horas in entrada['horario']['sabado']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['sabado'] = datos;
    datos = [];
    for (var horas in entrada['horario']['domingo']) {
      TimeOfDay inicio = horas['inicio'];
      TimeOfDay fin = horas['fin'];
      Map disponible = {
        'hora_inicial': inicio.hour,
        'minuto_inicial': inicio.minute,
        'hora_final': fin.hour,
        'minuto_final': fin.minute,
      };
      datos.add(disponible);
    }
    workerDaysAvailableEnviar['domingo'] = datos;
    datos = [];
  }

  Map getHorarioParaEnviar() {
    return workerDaysAvailableEnviar;
  }

  void setDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = Usuario(
        googleId: prefs.getString('googleId')!,
        userName: prefs.getString('userName')!,
        userEmail: prefs.getString('emailUser')!,
        avatar: prefs.getString('avatar')!);
  }

  Usuario getDatosUsuario() {
    return user!;
  }

  void cargar(myBusiness) {
    state = myBusiness;
  }

  void establecerWorkers(id, ref) async {
    workers = await API.getWorkers(id);
    API.reRender(ref);
  }

  List<Worker> obtenerWorkers() {
    return workers;
  }

  void setService(id, ref) async {
    services = await API.getService(id);
/*
    for (var element in workers) {
      element.imgPath[0] = await API.downloadImage(element.imgPath[0]);
    }*/
    API.reRender(ref);
  }

  List<Service> getService() {
    return services;
  }

  void setDias(dia, valor) {
    diasLaboralesGenerales[dia] = valor;
  }

  void limpiar() {
    state = [];
  }

  Map obtenerDias() {
    return diasLaboralesGenerales;
  }

  void setActualEmail(email) {
    actualEmail = email;
  }

  String getActualEmail() {
    return actualEmail;
  }

  void setActualBusiness(id) {
    actualBusiness = id;
  }

  String getActualBusiness() {
    return actualBusiness;
  }

  void eliminarHorario(dia, Map horario) {
    workerDaysAvailable[dia].remove(horario);
    print(workerDaysAvailable);
  }

  void cambiarHorario(dia, Map horario, TimeOfDay inicio, TimeOfDay fin) {
    //obtenerindice
    int index = workerDaysAvailable[dia].indexOf(horario);
    workerDaysAvailable[dia][index] = {'inicio': inicio, 'fin': fin};
  }

  void setDiasWorker2(Map entrada) {
    workerDaysAvailable = Map.from(generalSchedule);
  }

  void setDiasWorker(dia, TimeOfDay inicio, TimeOfDay fin) {
    workerDaysAvailable[dia].add({'inicio': inicio, 'fin': fin});
  }

  Map obtenerDiasWorker() {
    return workerDaysAvailable;
  }

  void copiarHorariosWorker(dia) {
    papelera = List.from(workerDaysAvailable[dia]);
  }

  void pegarHorariosWorker(dia) {
    workerDaysAvailable[dia] = List.from(papelera);
  }

  void borrarDiaWorker(dia) {
    workerDaysAvailable[dia] = [];
  }

  void setDiasGeneral(dia, TimeOfDay inicio, TimeOfDay fin) {
    generalSchedule[dia].add({'inicio': inicio, 'fin': fin});
  }

  Map obtenerDiasGeneral() {
    return generalSchedule;
  }

  void copiarHorariosGeneral(dia) {
    papelera = List.from(generalSchedule[dia]);
  }

  void pegarHorariosGeneral(dia) {
    generalSchedule[dia] = List.from(papelera);
  }

  void borrarDiaGeneral(dia) {
    generalSchedule[dia] = [];
  }

  void setCita({
    required DateTime fecha,
    required TimeOfDay horarioInicial,
    required TimeOfDay horarioFinal,
    required List servicios,
  }) {
    citaActual['dia'] = fecha.day;
    citaActual['mes'] = fecha.month;
    citaActual['year'] = fecha.year;
    citaActual['hora_inicial'] = horarioInicial.hour;
    citaActual['minuto_inicial'] = horarioInicial.minute;
    citaActual['hora_final'] = horarioFinal.hour;
    citaActual['minuto_final'] = horarioFinal.minute;
    citaActual['servicios'] = servicios;
  }

  Map getCita() {
    return citaActual;
  }

  void establecerDiasGeneral(entrada) {
    generalSchedule['lunes'] = [];
    for (var periodo in entrada['lunes']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['lunes'].add(anadir);
    }
    generalSchedule['martes'] = [];
    for (var periodo in entrada['martes']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['martes'].add(anadir);
    }
    generalSchedule['miercoles'] = [];
    for (var periodo in entrada['miercoles']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['miercoles'].add(anadir);
    }
    generalSchedule['jueves'] = [];
    for (var periodo in entrada['jueves']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['jueves'].add(anadir);
    }
    generalSchedule['viernes'] = [];
    for (var periodo in entrada['viernes']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['viernes'].add(anadir);
    }
    generalSchedule['sabado'] = [];
    for (var periodo in entrada['sabado']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['sabado'].add(anadir);
    }
    generalSchedule['domingo'] = [];
    for (var periodo in entrada['domingo']) {
      Map anadir = {
        'inicio': TimeOfDay(
            hour: periodo['hora_inicial'], minute: periodo['minuto_inicial']),
        'fin': TimeOfDay(
            hour: periodo['hora_final'], minute: periodo['minuto_final'])
      };
      generalSchedule['domingo'].add(anadir);
    }
  }

  void setFecha(DateTime fechaEscogida) {
    fecha = fechaEscogida;
  }

  DateTime getFecha() {
    return fecha;
  }

  void setHora(TimeOfDay horaEscogida) {
    hora = horaEscogida;
  }

  TimeOfDay getHora() {
    return hora;
  }

  void setHoraFinal(TimeOfDay horaEscogida) {
    horaFinal = horaEscogida;
  }

  TimeOfDay getHoraFinal() {
    return horaFinal;
  }

  void setDuration(dur) {
    duration = dur;
  }

  Duration getDuration() {
    return duration;
  }

  void setSocketState(valor) {
    socketConectado = valor;
  }

  bool getSocketState() {
    return socketConectado;
  }

  void setPage(entrada) {
    pagina = entrada;
  }

  Type getPage() {
    return pagina;
  }
}

Map diasLaboralesGenerales = {
  'lunes': true,
  'martes': true,
  'miercoles': true,
  'jueves': true,
  'viernes': true,
  'sabado': true,
  'domingo': true,
};

Map workerDaysAvailable = {
  'lunes': [
    {
      'inicio': TimeOfDay(hour: 7, minute: 0),
      'fin': TimeOfDay(hour: 13, minute: 0)
    },
    {
      'inicio': TimeOfDay(hour: 14, minute: 0),
      'fin': TimeOfDay(hour: 17, minute: 0)
    }
  ],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};

Map generalSchedule = {
  'lunes': [
    {
      'inicio': TimeOfDay(hour: 7, minute: 0),
      'fin': TimeOfDay(hour: 13, minute: 0)
    },
    {
      'inicio': TimeOfDay(hour: 14, minute: 0),
      'fin': TimeOfDay(hour: 17, minute: 0)
    }
  ],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};

Map workerDaysAvailableEnviar = {
  'lunes': [
    {
      'hora_inicial': 7,
      'minuto_inicial': 0,
      'hora_final': 13,
      'minuto_final': 0,
    },
    {
      'inicio': TimeOfDay(hour: 14, minute: 0),
      'fin': TimeOfDay(hour: 17, minute: 0)
    }
  ],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};

Map citaActual = {
  'dia': '',
  'mes': '',
  'year': '',
  'servicios': [],
  'hora_inicial': '',
  'minuto_inicial': '',
  'hora_final': '',
  'minuto_final': '',
};

DateTime fecha = DateTime.now();

TimeOfDay hora = TimeOfDay.now();
TimeOfDay horaFinal = TimeOfDay.now();
List<Worker> workers = [];
List<Service> services = [];
List papelera = [];

String actualBusiness = '';

String actualEmail = '';

Duration duration = const Duration(hours: 0, minutes: 30);

bool socketConectado = false;

Usuario? user;

Type pagina = HomePage().runtimeType;
