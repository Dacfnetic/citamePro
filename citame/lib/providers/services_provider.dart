import 'package:citame/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesProvider =
    StateNotifierProvider<ServicesNotifier, List<Service>>((ref) {
  return ServicesNotifier();
});

class ServicesNotifier extends StateNotifier<List<Service>> {
  ServicesNotifier() : super([]);

  void anadir(entrada) {
    state = [...state, entrada];
    /*List<double> x = [];
    x = lista.where((servicio) => servicio.nombreServicio != entrada.data);
    servicios = List.from(x);*/
  }

  void remover(entrada) {
    List<Service> nueva = state.where((element) => element != entrada).toList();

    state = nueva;
  }

  void limpiar() {
    state = [];
  }

  void actualizar(servicios) {
    state = servicios;
  }

  /*void eliminar(entrada) {
    var index = state.where((element) => element.data)
    state = state.removeAt(index);
  }*/
}
