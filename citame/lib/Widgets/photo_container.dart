import 'dart:io';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EspacioParaSubirFotoDeNegocio extends ConsumerWidget {
  EspacioParaSubirFotoDeNegocio({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String ruta = ref.watch(imgProvider);

    Future pickImageFromCamera() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      var comprimida = await FlutterImageCompress.compressAndGetFile(
          returnedImage!.path, '${returnedImage.path}compressed.jpg',
          minHeight: 640, minWidth: 480, quality: 80);

      if (comprimida != null) {
        final camino = comprimida.path;
        ref.watch(imgProvider.notifier).changeState(camino);
      }
    }

    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: AssetImage('lib/assets/store.jpg'), fit: BoxFit.fitHeight),
        border: Border.all(color: Colors.black),
      ),
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ruta != ''
                ? Image.file(
                    File(ruta),
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                  )
                : Text(''),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    API.pickImageFromGallery(ref);
                  },
                  child: Text('Subir imagen'),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: Anthony va a ver como incluir la foto del negocio
                    pickImageFromCamera();
                  },
                  child: Text('Tomar foto'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
