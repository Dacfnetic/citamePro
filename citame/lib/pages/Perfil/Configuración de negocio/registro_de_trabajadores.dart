import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/profile_inside.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistroDeTrabajadores extends StatelessWidget {
  // #region parámetros
  const RegistroDeTrabajadores(
      {super.key,
      required this.workers,
      required this.trabajadores,
      required this.ref});

  final List<Worker> workers;
  final List<WorkerBox> trabajadores;
  final WidgetRef ref;
  // #endregion

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // #region para describir que hace la página
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
        // #endregion
        // #region mostrar trabajadores existentes
        workers.isNotEmpty
            ? Expanded(
                child: ListView(shrinkWrap: true, children: trabajadores))
            : Container(),
        // #endregion
        // #region botón para agregar trabajadores
        ElevatedButton.icon(
          onPressed: () {
            ref
                .read(myBusinessStateProvider.notifier)
                .setHorarioGeneralDeTrabajador();
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
        // #endregion
      ],
    );
  }
}
