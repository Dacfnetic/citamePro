import 'dart:io';

import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInsidePage extends ConsumerWidget {
  ProfileInsidePage({super.key});
  final TextEditingController workerName = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String ruta = ref.watch(imgProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(240, 240, 240, 1),
          child: ListView(
            children: [
              Container(
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
                              child: ruta != ''
                                  ? Image.file(
                                      File(ruta),
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
                          Cuadro(
                              control: workerName,
                              texto: 'Nombre del trabajador'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(28)),
                      width: 100,
                      height: 100,
                      child: TextButton(
                        onPressed: () {
                          API.timePicker(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_clock),
                            Text(
                              'Hora',
                              style: API.estiloJ14gris,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
