import 'package:citame/models/business_model.dart';
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

  void setDias(dia, valor) {
    diasLaboralesGenerales[dia] = valor;
  }

  void limpiar() {
    state = [];
  }

  Map obtenerDias() {
    return diasLaboralesGenerales;
  }

  void setDiasWorker(dia, TimeOfDay inicio, TimeOfDay fin) {
    workerDaysAvailable[dia].add({'inicio': inicio, 'fin': fin});
  }

  void eliminarHorario(dia, Map horario) {
    workerDaysAvailable[dia].remove(horario);
  }

  void cambiarHorario(dia, Map horario, TimeOfDay inicio, TimeOfDay fin) {
    //obtenerindice
    int index = workerDaysAvailable[dia].indexOf(horario);
    workerDaysAvailable[dia][index] = {'inicio': inicio, 'fin': fin};
  }

  Map obtenerDiasWorker() {
    return workerDaysAvailable;
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
  'lunes': [],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};
