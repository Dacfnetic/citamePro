import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EspacioParaSubirFotoDeNegocio extends StatefulWidget {
  const EspacioParaSubirFotoDeNegocio({
    super.key,
  });

  @override
  State<EspacioParaSubirFotoDeNegocio> createState() =>
      _EspacioParaSubirFotoDeNegocioState();
}

class _EspacioParaSubirFotoDeNegocioState
    extends State<EspacioParaSubirFotoDeNegocio> {
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    Future pickImageFromGallery() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage != null) {
        final camino = returnedImage.path;
        setState(() {
          selectedImage = File(camino);
        });
      }
    }

    Future pickImageFromCamera() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnedImage != null) {
        final camino = returnedImage.path;
        setState(() {
          selectedImage = File(camino);
        });
      }
    }

    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amber,
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: /*Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.red,
                border: Border.all(width: 5),
              ),*/
                ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    )
                  : Text('Sube una imagen prro'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: Anthony va a ver como incluir la foto del negocio
                    pickImageFromGallery();
                  },
                  child: Text('Subir imagen'),
                ),
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
