import 'package:citame/Widgets/business_card.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final ownBusinessProvider =
    StateNotifierProvider<BusinessListNotifier, List<BusinessCard>>((ref) {
  print('reimprimir');
  return BusinessListNotifier();
});

class BusinessListNotifier extends StateNotifier<List<BusinessCard>> {
  BusinessListNotifier() : super(negocios);

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

  void cargar(BuildContext context, WidgetRef ref) async {
    List<Business> ownBusiness;
    List<BusinessCard> negocios;
    ownBusiness = await API.getOwnerBusiness(context, ref);
    if (ownBusiness.length != 0) {
      negocios = ownBusiness.map((e) {
        return (BusinessCard(
          nombre: e.businessName,
          categoria: e.category,
          latitud: double.parse(e.latitude),
          longitud: double.parse(e.longitude),
          rating: 5.0,
          imagen: e.imgPath,
          description: e.description,
        ));
      }).toList();
      if (state.length != negocios.length) {
        state = negocios;
      }
    }
  }
}

LatLng businessPosition = LatLng(0, 0);

List<BusinessCard> negocios = [
  //TODO: Cargar desde la base de datos
];
