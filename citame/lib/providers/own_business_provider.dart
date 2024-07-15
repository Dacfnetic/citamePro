import 'dart:convert';
import 'package:citame/Widgets/business_card.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/services/user_services/show_own_business.dart';
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
    List<BusinessCard> negocios = [];
    ownBusiness = await ShowOwnBusiness.showOwnBusiness(context, ref);
    if (ownBusiness.isNotEmpty) {
      for (var element in ownBusiness) {
        negocios.add(BusinessCard(
          nombre: element.businessName,
          id: element.idMongo,
          categoria: element.category,
          latitud: double.parse(element.latitude),
          longitud: double.parse(element.longitude),
          rating: 5.0,
          imagen: element.imgPath,
          description: element.description,
          email: element.email,
          horario: element.horario,
          isDueno: true,
        ));
      }
    }
    state = negocios;
  }

  void actualizarUnNegocio(
      Map negocio, BuildContext context, WidgetRef ref) async {
    negocios = state;
    final index =
        negocios.indexWhere((element) => element.id == negocio['_id']);
    Map hora = jsonDecode(negocio['horario']);

    //Añadir carta cambiada

    negocios.insert(
        index,
        BusinessCard(
          nombre: negocios[index].nombre,
          id: negocios[index].id,
          categoria: negocios[index].categoria,
          latitud: negocios[index].latitud,
          longitud: negocios[index].longitud,
          rating: 5.0,
          imagen: negocios[index].imagen,
          description: negocios[index].description,
          email: negocios[index].email,
          horario: hora,
          isDueno: true,
        ));
    negocios.removeAt(index + 1);

    state = negocios;
  }

  Map obtenerHorario(String idNegocio) {
    negocios = state;
    final index = negocios.indexWhere((element) => element.id == idNegocio);
    Map hora = negocios[index].horario;
    return hora;
  }
}

LatLng businessPosition = LatLng(0, 0);

List<BusinessCard> negocios = [];
