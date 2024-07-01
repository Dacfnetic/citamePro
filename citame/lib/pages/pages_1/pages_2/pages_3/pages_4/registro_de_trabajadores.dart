import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/pages_5/profile_inside.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistroDeTrabajadores extends StatelessWidget {
  const RegistroDeTrabajadores(
      {super.key,
      required this.workers,
      required this.trabajadores,
      required this.ref});

  final List<Worker> workers;
  final List<WorkerBox> trabajadores;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Perfiles', style: API.estiloJ24negro),
              Text(
                  'Crea los perfiles de tu personal para que tus clientes puedan conocerlos.',
                  style: API.estiloJ14gris),
            ],
          ),
        ),
        workers.isNotEmpty
            ? Expanded(
                child: ListView(shrinkWrap: true, children: trabajadores))
            : Container(),
        ElevatedButton.icon(
          onPressed: () {
            ref.read(myBusinessStateProvider.notifier).setDiasWorker2(ref
                .read(myBusinessStateProvider.notifier)
                .obtenerDiasGeneral());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileInsidePage(),
                ));
          },
          icon: Icon(Icons.plus_one),
          label: Text('Agregar más'),
        ),
        SizedBox(height: 24)
      ],
    );
  }
}
