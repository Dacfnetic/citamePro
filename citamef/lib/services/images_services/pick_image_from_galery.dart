import 'dart:async';
import 'dart:io';
import 'package:citame/providers/img_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// ignore: library_prefixes
abstract class PickImageFromGalery {
  static Future pickImageFromGallery(WidgetRef ref) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      File imagen = File(returnedImage.path);
      ref.read(imgProvider.notifier).changeState(imagen);
    }
  }
}
