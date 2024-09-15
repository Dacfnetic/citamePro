import 'dart:async';
import 'dart:io';
import 'package:citame/providers/img_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// ignore: library_prefixes
abstract class PickImageFromCamera {
  static Future pickImageFromCamera(WidgetRef ref) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      /*var comprimida = await FlutterImageCompress.compressAndGetFile(
          returnedImage.path, '${returnedImage.path}compressed.jpg',
          minHeight: 640, minWidth: 480, quality: 80);*/
      /*if (comprimida != null) {
        final camino = comprimida.path;
        ref.watch(imgProvider.notifier).changeState(camino);
      }*/
      File imagen = File(returnedImage.path);
      ref.read(imgProvider.notifier).changeState(imagen);
    }
  }
}
