import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/providers/workers_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BotonParaGuardarConfiguracionDelNegocio extends StatelessWidget {
  const BotonParaGuardarConfiguracionDelNegocio(
      {super.key, required this.horas, required this.ref});

  final WidgetRef ref;
  final Schedule horas;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('negocioActual',
          ref.read(myBusinessStateProvider.notifier).getActualBusiness());
      String idNegocio = prefs.getString('negocioActual')!;
      ref
          .read(myBusinessStateProvider.notifier)
          .setHorarioParaEnviar(horas.toJson());
      Map horarioGeneral =
          ref.read(myBusinessStateProvider.notifier).getHorarioParaEnviar();
      //Llamar al método de guardar configuración general
      if (context.mounted) {
        if (ref
            .read(myBusinessStateProvider.notifier)
            .getSePuedenGuardarCambiosGeneralesCambio()) {
          ref
              .read(myBusinessStateProvider.notifier)
              .noSePuedenGuardarCambiosGeneralesCambio();

          Map contenido = await API.guardarConfiguracionGeneral(
              context,
              idNegocio,
              horarioGeneral,
              ref.read(servicesProvider),
              ref.read(workersProvider),
              ref);
        }
      }
      if (context.mounted) {
        Navigator.pop(context);
        //Navigator.pop(context);
      }
    });
  }
}
