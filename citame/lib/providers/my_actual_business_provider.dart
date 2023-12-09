import 'package:flutter_riverpod/flutter_riverpod.dart';

final actualBusinessProvider =
    StateNotifierProvider<MyActualBusiness, String>((ref) {
  return MyActualBusiness();
});

class MyActualBusiness extends StateNotifier<String> {
  MyActualBusiness() : super('');

  void actualizar(page) {
    state = page;
  }
}
