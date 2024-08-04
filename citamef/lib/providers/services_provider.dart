import 'package:citame/models/service_model.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final servicesProvider =
    StateNotifierProvider<ServicesNotifier, List<Service>>((ref) {
  return ServicesNotifier();
});

class ServicesNotifier extends StateNotifier<List<Service>> {
  ServicesNotifier() : super([]);

  void anadir(entrada, context, ref) async {
    List<String> nombres = [];
    for (var servicio in state) {
      nombres.add(servicio.nombreServicio);
    }
    if (nombres.contains(entrada.nombreServicio)) {
      await API.toast(context, "Ese servicio ya está registrado");
      return;
    }
    ref
        .read(myBusinessStateProvider.notifier)
        .sePuedenGuardarCambiosGeneralesCambio();
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

  List<Service> obtener() {
    return state;
  }

  /*void eliminar(entrada) {
    var index = state.where((element) => element.data)
    state = state.removeAt(index);
  }*/
}
