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

//TODO: Cargar categorías ya sea desde el backend o desde aquí
List<HomeRow> categorias = [
  HomeRow(
    categoria: 'Salud',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Barberias',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Entretenimiento',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Atención profesional',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Cuidado de vehiculos',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Salud',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Estetica y belleza',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
  HomeRow(
    categoria: 'Restaurantes',
    imagen:
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cd1fc4e4-5d02-4f18-afd7-a1ea42ff1f73/sportswear-club-fleece-pullover-hoodie-Gw4Nwq.png',
  ),
];
