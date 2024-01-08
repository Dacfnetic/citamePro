import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesProvider =
    StateNotifierProvider<ServicesNotifier, List<Text>>((ref) {
  return ServicesNotifier();
});

class ServicesNotifier extends StateNotifier<List<Text>> {
  ServicesNotifier() : super([]);

  void anadir(entrada) {
    state = [...state, Text(entrada.data)];
  }

  void remover(entrada) {
    List<Text> nueva =
        state.where((element) => element.data != entrada.data).toList();

    state = nueva;
  }

  /*void eliminar(entrada) {
    var index = state.where((element) => element.data)
    state = state.removeAt(index);
  }*/
}
