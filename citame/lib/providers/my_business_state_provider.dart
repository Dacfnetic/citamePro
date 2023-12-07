import 'package:citame/models/business_model.dart';
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
