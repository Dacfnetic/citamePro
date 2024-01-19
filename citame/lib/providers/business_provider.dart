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
      state = noBorrar;
    } else {
      List<BusinessCard> negociosFiltrados = noBorrar
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
    noBorrar = [];
    state = [];
  }

  void cargar(BuildContext context) async {
    List<Business> allBusiness;
    List<BusinessCard> negocios = [];

    allBusiness = await API.getAllBusiness(context);
    if (allBusiness.isNotEmpty) {
      for (var element in allBusiness) {
        element.imgPath[0] = await API.downloadImage(element.imgPath[0]);
        negocios.add(BusinessCard(
          nombre: element.businessName,
          id: element.idMongo,
          categoria: element.category,
          latitud: double.parse(element.latitude),
          longitud: double.parse(element.longitude),
          rating: 5.0,
          imagen: element.imgPath[0],
          description: element.description,
          email: element.email,
          horario: element.horario,
          isDueno: false,
        ));
        cambiarAhoraALV(negocios);
      }
      noBorrar = List.from(negocios);
      state = negocios;
    }
  }

  void cambiarAhoraALV(entrada) {
    state = List.from(entrada);
  }

  void noExiste(BuildContext context) {
    API.noHay(context);
  }
}

LatLng businessPosition = LatLng(0, 0);

List<BusinessCard> negocios = [];

List<BusinessCard> noBorrar = [];
