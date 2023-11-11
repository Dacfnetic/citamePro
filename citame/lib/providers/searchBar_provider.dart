import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchBarProvider =
    StateNotifierProvider<SearchBarNotifier, String>((ref) {
  return SearchBarNotifier();
});

class SearchBarNotifier extends StateNotifier<String> {
  SearchBarNotifier() : super("");

  void actualizar(value) {
    state = value;
  }
}
