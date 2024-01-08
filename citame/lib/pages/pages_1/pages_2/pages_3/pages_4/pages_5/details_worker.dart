import 'dart:typed_data';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsWorker extends ConsumerWidget {
  const DetailsWorker(
      {super.key, required this.imagen, required this.trabajador});

  final Uint8List imagen;
  final Worker trabajador;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usuario user = ref.read(myBusinessStateProvider.notifier).getDatosUsuario();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: API.estiloJ16negro,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(
                  imagen,
                  width: double.infinity,
                  height: 330,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        trabajador.puesto,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                        child: Text(
                          trabajador.name,
                        ),
                      ),
                      Text(
                        trabajador.email,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                                width: 1.5)),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(Icons.chat_bubble_rounded,
                                      color: Color(0xFF4B39EF), size: 30),
                                  SizedBox(width: 5),
                                  Text('Mensaje'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              child: VerticalDivider(
                                thickness: 2,
                                indent: 12,
                                endIndent: 12,
                                color: Color(0xFFE0E3E7),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.menu_book,
                                      color: Color(0xFF4B39EF), size: 30),
                                  SizedBox(width: 5),
                                  Text('Agendar Cita'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
