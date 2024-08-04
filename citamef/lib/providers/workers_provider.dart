import 'dart:convert';

import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final workersProvider =
    StateNotifierProvider<WorkersNotifier, List<Worker>>((ref) {
  return WorkersNotifier();
});

class WorkersNotifier extends StateNotifier<List<Worker>> {
  WorkersNotifier() : super([]);

  void anadir(entrada, context, ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List negocios = jsonDecode(prefs.getString('datosDeNegocios')!);

    Map negocio = {};
    for (var neg in negocios) {
      if (neg["idMongo"] == prefs.getString('negocioActual')) {
        negocio = neg;
      }
    }

    List trabajadores = negocio["workers"];

    List correos = trabajadores.map((trabajador) => trabajador.email).toList();

    if (correos.contains(entrada.email)) {
      await API.toast(context, "Ese correo ya está registrado");
      return;
    }

    ref
        .read(myBusinessStateProvider.notifier)
        .sePuedenGuardarCambiosGeneralesCambio();
    state = [...state, entrada];
    Navigator.pop(context);
  }

  void remover(entrada) {
    List<Worker> nueva = state.where((element) => element != entrada).toList();
    state = nueva;
  }

  void limpiar() {
    state = [];
  }

  void actualizar(servicios) {
    state = servicios;
  }

  List<Worker> obtener() {
    return state;
  }
}
