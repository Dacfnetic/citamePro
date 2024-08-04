import 'dart:io';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/services/images_services/pick_image_from_camera.dart';
import 'package:citame/services/images_services/pick_image_from_galery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EspacioParaSubirFotoDeNegocio extends ConsumerWidget {
  EspacioParaSubirFotoDeNegocio({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    File ruta = ref.watch(imgProvider);

    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: ruta.path == ""
            ? DecorationImage(
                image: AssetImage('lib/assets/store.jpg'),
                fit: BoxFit.fitHeight,
              )
            : DecorationImage(
                image: FileImage(File('')),
                fit: BoxFit.fitHeight,
              ),
        border: Border.all(color: Colors.black),
      ),
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ruta.path.isNotEmpty
                ? Image.file(
                    ruta,
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
                    PickImageFromGalery.pickImageFromGallery(ref);
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
                    PickImageFromCamera.pickImageFromCamera(ref);
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
