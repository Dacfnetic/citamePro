import 'package:citame/Widgets/business_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void filtrar2(catg) {
    List<BusinessCard> catgFiltrada =
        negocios.where((item) => item.categoria == catg).toList();
  }
}

//TODO: Cargar negocios desde el backend

List<BusinessCard> negocios = [
  BusinessCard(
      nombre: 'Barberia Nixon',
      categoria: 'Barberias',
      distancia: 32, //TODO: Calcular respecto a la ubicación del usuario
      rating: 4.25, //TODO: Calcular haciendo el promedio de las revies.
      imagen:
          'https://source.unsplash.com/random/1280x720?beach&9'), //TODO: Cargar desde la base de datos
  BusinessCard(
      nombre: 'Brothers',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Otra',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Tijeras',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Pelo',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Gel',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Sapo',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Caca',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Dart',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
  BusinessCard(
      nombre: 'Flutter',
      categoria: 'Barberias',
      distancia: 32,
      rating: 4.25,
      imagen: 'https://source.unsplash.com/random/1280x720?beach&9'),
];
