import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workersProvider =
    StateNotifierProvider<WorkersNotifier, List<Worker>>((ref) {
  return WorkersNotifier();
});

class WorkersNotifier extends StateNotifier<List<Worker>> {
  WorkersNotifier() : super([]);

  void anadir(entrada, context, ref) async {
    List<String> correos = [];
    for (var correo in state) {
      correos.add(correo.email);
    }
    if (correos.contains(entrada.email)) {
      await API.mensaje2(context, "Ese correo ya está registrado");
      return;
    }
    ref
        .read(myBusinessStateProvider.notifier)
        .sePuedenGuardarCambiosGeneralesCambio();
    state = [...state, entrada];
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
