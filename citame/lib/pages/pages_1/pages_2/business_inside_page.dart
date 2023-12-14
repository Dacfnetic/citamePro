import 'dart:typed_data';
import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/reservation_page.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessInsidePage extends ConsumerWidget {
  BusinessInsidePage({
    Key? key,
    required this.businessName,
    required this.imagen,
    required this.description,
  }) : super(key: key);
  final String businessName;
  final Uint8List imagen;
  final String description;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reRenderProvider);
    List<Worker> workers =
        ref.watch(myBusinessStateProvider.notifier).obtenerWorkers();
    List<WorkerBox> trabajadores = workers
        .map((e) => WorkerBox(
              worker: e,
              ref: ref,
              imagen: e.imgPath,
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(businessName, style: API.estiloJ24negro),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.memory(
                    imagen,
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                Text('Horario'),
                Text('Descripción'),
                Text(description, style: API.estiloJ14gris),
                Text('Servicios', style: API.estiloJ24negro),
                Text(
                    'Cargar desde backend tenemos que cambiar el modelo de negocio para agregarle los servicios',
                    style: API.estiloJ16negro),
                workers.isNotEmpty
                    ? ListView(shrinkWrap: true, children: trabajadores)
                    : Container(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservationPage(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text('Foto')),
                      Expanded(
                          child: Column(
                        children: [
                          Text('Nombre del worker'),
                          Text('Puesto del worker')
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
