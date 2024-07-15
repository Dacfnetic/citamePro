import 'dart:io';
import 'dart:typed_data';

import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/AUN%20NO%20S%C3%89/details_worker.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:citame/services/images_services/pick_image_from_galery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerBox extends ConsumerWidget {
  const WorkerBox({
    super.key,
    required this.worker,
    required this.ref,
    required this.imagen,
    required this.isDueno,
    required this.imagenParaDueno,
  });

  final bool isDueno;
  final Worker worker;
  final Uint8List imagen;
  final File imagenParaDueno;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isDueno) {
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ), // Color de fondo del Container

        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.transparent,
                  width: 2,
                ),
              ),
              child: SizedBox(
                height: 90,
                width: 90,
                child: TextButton(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      imagenParaDueno,
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onPressed: () {
                    PickImageFromGalery.pickImageFromGallery(ref);
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(worker.name, style: API.estiloJ24negro),
                  Text(worker.puesto,
                      style: TextStyle(color: Colors.grey.withOpacity(0.9))),
                  //Text(horas, style: API.estiloJ14gris),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                API.deleteWorkerInBusiness(
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .getActualBusiness(),
                  worker.id,
                  worker.idWorker,
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsWorker(imagen: imagen, trabajador: worker)));
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),

          //height: 300,
          //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white, // Color de fondo del Container
            boxShadow: [
              BoxShadow(
                color: Colors.grey, // Color de la sombra
                offset: Offset(0.0, 3.0), // Desplazamiento de la sombra
                blurRadius: 5.0, // Radio de desenfoque de la sombra
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                ),
                child: SizedBox(
                  height: 90,
                  width: 90,
                  child: TextButton(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.memory(
                        imagen,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onPressed: () {
                      //API.pickImageFromGallery(ref);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(worker.name, style: API.estiloJ24negro),
                    Text(
                      worker.puesto,
                      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    )
                    //Text(horas, style: API.estiloJ14gris),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              /*ElevatedButton(
                  onPressed: () {
                    API.deleteWorkerInBusiness(
                      ref
                          .read(myBusinessStateProvider.notifier)
                          .getActualBusiness(),
                      worker.id,
                      worker.idWorker,
                    );
                  },
                  child: Text('Borrar')),*/
            ],
          ),
        ),
      );
    }
  }
}
