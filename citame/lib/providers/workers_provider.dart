import 'package:citame/models/worker_moder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workersProvider =
    StateNotifierProvider<WorkersNotifier, List<Worker>>((ref) {
  return WorkersNotifier();
});

class WorkersNotifier extends StateNotifier<List<Worker>> {
  WorkersNotifier() : super([]);

  void anadir(entrada) {
    state = [...state, entrada];
    /*List<double> x = [];
    x = lista.where((servicio) => servicio.nombreServicio != entrada.data);
    servicios = List.from(x);*/
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

  /*void eliminar(entrada) {
    var index = state.where((element) => element.data)
    state = state.removeAt(index);
  }*/
}
