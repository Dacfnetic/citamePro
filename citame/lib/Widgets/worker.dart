import 'dart:typed_data';

import 'package:citame/models/worker_moder.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkerBox extends StatelessWidget {
  const WorkerBox({
    super.key,
    required this.worker,
    required this.ref,
    required this.imagen,
  });
  final Worker worker;
  final List<int> imagen;
  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    Uint8List esta = Uint8List.fromList(imagen);
    String horas = worker.horario;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
      //height: 300,
      //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black,
        )
      ]),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(16),
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
                    esta,
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
                Text(horas, style: API.estiloJ14gris),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
