import 'dart:io';

import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*
class WorkerBox extends StatelessWidget {
  const WorkerBox({
    super.key,
    required this.worker,
    required this.ref,
  });
  final Map worker;

  final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
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
                    child: worker.ruta != ''
                        ? Image.file(
                            File(worker.ruta),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Text('')),
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
                Text('Nombre del worker', style: API.estiloJ16negro),
                Text('Horarios del worker', style: API.estiloJ14gris),
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
*/