import 'package:citame/Widgets/home_row.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    StateNotifierProvider<CategoristListNotifier, List<HomeRow>>((ref) {
  print('reimprimir');
  return CategoristListNotifier();
});

class CategoristListNotifier extends StateNotifier<List<HomeRow>> {
  CategoristListNotifier() : super(categorias);

  void inicializar() {
    state = categorias;
  }

  void filtrar(value) {
    if (value == "") {
      state = categorias;
    } else {
      List<HomeRow> categoriasFiltradas = categorias
          .where((item) => item.categoria
              .toLowerCase()
              .contains(value.toString().toLowerCase()))
          .toList();
      state = categoriasFiltradas;
    }
  }
}

List<HomeRow> categorias = [
  HomeRow(
    categoria: 'Abogados',
    imagen: 'lib/assets/Abogados.jpeg',
  ),
  HomeRow(
    categoria: 'Barberias',
    imagen: 'lib/assets/Barberias.jpeg',
  ),
  HomeRow(
    categoria: 'Belleza',
    imagen: 'lib/assets/Belleza.jpeg',
  ),
  HomeRow(
    categoria: 'Doctores y dentistas',
    imagen: 'lib/assets/Doctores.jpeg',
  ),
  HomeRow(
    categoria: 'Entretenimiento',
    imagen: 'lib/assets/Entretenimiento.jpeg',
  ),
  HomeRow(
    categoria: 'Mecanicos',
    imagen: 'lib/assets/Transportes.jpeg',
  ),
];
