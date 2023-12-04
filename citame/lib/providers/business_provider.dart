import 'package:citame/Widgets/business_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final businessProvider =
    StateNotifierProvider<BusinessListNotifier, List<BusinessCard>>((ref) {
  print('reimprimir');
  return BusinessListNotifier();
});

class BusinessListNotifier extends StateNotifier<List<BusinessCard>> {
  BusinessListNotifier() : super(negocios);

  void inicializar() {
    state = negocios;
  }

  void filtrar(value) {
    if (value == "") {
      state = negocios;
    } else {
      List<BusinessCard> negociosFiltrados = negocios
          .where((item) => item.nombre
              .toLowerCase()
              .contains(value.toString().toLowerCase()))
          .toList();
      state = negociosFiltrados;
    }
  }

  void businessLocation(pos) {
    businessPosition = pos;
  }

  double longitud() {
    return businessPosition.longitude;
  }

  double latitud() {
    return businessPosition.latitude;
  }

  void agregarNegocio(nombre, categoria, latitud, longitud, rating, imagen) {
    negocios = [
      ...negocios,
      BusinessCard(
          nombre: nombre,
          categoria: categoria,
          latitud: latitud,
          longitud: longitud,
          rating: rating,
          imagen: imagen)
    ];
  }
}

LatLng businessPosition = LatLng(0, 0);

List<BusinessCard> negocios = [
  //TODO: Cargar desde la base de datos
];
