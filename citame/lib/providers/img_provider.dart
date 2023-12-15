import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final imgProvider = StateNotifierProvider<ImgNotifier, File>((ref) {
  return ImgNotifier();
});

class ImgNotifier extends StateNotifier<File> {
  ImgNotifier() : super(File(''));

  void changeState(path) {
    state = path;
  }
}
