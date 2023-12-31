import 'dart:typed_data';

import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/pages_5/details_worker.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerBox extends ConsumerWidget {
  const WorkerBox({
    super.key,
    required this.worker,
    required this.ref,
    required this.imagen,
    required this.isDueno,
  });

  final bool isDueno;
  final Worker worker;
  final Uint8List imagen;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isDueno) {
      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 3),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ), // Color de fondo del Container

        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Color(0x4d39d2c0),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xff39d2c0),
                  width: 2,
                ),
              ),
              child: SizedBox(
                height: 90,
                width: 90,
                child: TextButton(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.memory(
                      imagen,
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onPressed: () {
                    API.pickImageFromGallery(ref);
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(worker.name, style: API.estiloJ16negro),
                  Text(worker.puesto),
                  //Text(horas, style: API.estiloJ14gris),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  API.deleteWorkerInBusiness(
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .getActualBusiness(),
                    worker.id,
                    worker.idWorker,
                  );
                },
                child: Text('Borrar')),
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
          margin: EdgeInsets.fromLTRB(5, 4, 5, 4),

          //height: 300,
          //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
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
                  color: Color(0x4d39d2c0),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xff39d2c0),
                    width: 2,
                  ),
                ),
                child: SizedBox(
                  height: 90,
                  width: 90,
                  child: TextButton(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        imagen,
                        width: double.infinity,
                        height: 230,
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
