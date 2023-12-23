import 'package:citame/models/business_model.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myBusinessStateProvider =
    StateNotifierProvider<MyBusinessStateNotifier, List<Business>>((ref) {
  return MyBusinessStateNotifier();
});

class MyBusinessStateNotifier extends StateNotifier<List<Business>> {
  MyBusinessStateNotifier() : super([]);

  void cargar(myBusiness) {
    state = myBusiness;
  }

  void establecerWorkers(id, ref) async {
    workers = await API.getWorkers(id);

    for (var element in workers) {
      element.imgPath[0] = await API.downloadImage(element.imgPath[0]);
    }
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
