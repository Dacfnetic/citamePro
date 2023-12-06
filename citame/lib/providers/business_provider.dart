import 'package:citame/Widgets/business_card.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';

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

  int cantidad() {
    return state.length;
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

  void limpiar() {
    state = [];
  }

  void cargar(BuildContext context) async {
    List<Business> allBusiness;
    List<BusinessCard> negocios;

    allBusiness = await API.getAllBusiness(context);
    negocios = allBusiness.map((e) {
      return (BusinessCard(
        nombre: e.businessName,
        categoria: e.category,
        latitud: double.parse(e.latitude),
        longitud: double.parse(e.longitude),
        rating: 5.0,
        imagen: e.imgPath,
      ));
    }).toList();
    state = negocios;
  }

  void noExiste(BuildContext context) {
    API.noHay(context);
  }
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

LatLng businessPosition = LatLng(0, 0);

List<BusinessCard> negocios = [];
