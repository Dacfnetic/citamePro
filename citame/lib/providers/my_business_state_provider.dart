import 'package:citame/models/business_model.dart';
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

  void establecerWorkers(email, nombre, ref) async {
    workers = await API.getWorkers(email, nombre);
    API.reRender(ref);
  }

  List<Worker> obtenerWorkers() {
    return workers;
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

  void setActualBusiness(businessName) {
    actualBusiness = businessName;
  }

  String getActualBusiness() {
    return actualBusiness;
  }

  void setDiasWorker(dia, TimeOfDay inicio, TimeOfDay fin) {
    workerDaysAvailable[dia].add({'inicio': inicio, 'fin': fin});
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

List<Worker> workers = [];

List papelera = [];

String actualBusiness = '';

String actualEmail = '';
