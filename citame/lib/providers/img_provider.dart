import 'package:flutter_riverpod/flutter_riverpod.dart';

final imgProvider = StateNotifierProvider<ImgNotifier, String>((ref) {
  return ImgNotifier();
});

class ImgNotifier extends StateNotifier<String> {
  ImgNotifier() : super('');

  void changeState(path) {
    state = path;
  }
}
