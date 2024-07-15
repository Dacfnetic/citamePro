import 'dart:typed_data';
import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/caja_de_servicios.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/configuracion_general_del_negocio.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/providers/workers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuPage extends ConsumerWidget {
  MenuPage({
    super.key,
  });

  final TextEditingController servicio = TextEditingController();
  final TextEditingController precio = TextEditingController();
  final TextEditingController duracion = TextEditingController();
  final GlobalKey<FormState> validacion = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // #region aqui se crean las listas que vienen de los providers

    List<Service> listaDeServicios = ref.watch(servicesProvider);

    Map horario =
        ref.watch(myBusinessStateProvider.notifier).obtenerDiasGeneral();

    Schedule horas = Schedule(horario: horario);

    List<Worker> workers = ref.watch(workersProvider);

    List<CajaDeServicios> servicios = listaDeServicios
        .map((servicio) => CajaDeServicios(
            nombre: servicio.nombreServicio,
            precio: servicio.precio.toStringAsFixed(2),
            duracion: servicio.duracion,
            esDueno: true))
        .toList();

    List<WorkerBox> trabajadores = workers
        .map((e) => WorkerBox(
              worker: e,
              ref: ref,
              imagen: Uint8List(0),
              imagenParaDueno: e.imgPath[0],
              isDueno: true,
            ))
        .toList();
    // #endregion

    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          ref.read(reRenderProvider.notifier).reRender();
        },
        child: ConfiguracionGeneralDelNegocio(
            servicios: servicios,
            validacion: validacion,
            servicio: servicio,
            precio: precio,
            horario: horario,
            workers: workers,
            trabajadores: trabajadores,
            horas: horas,
            ref: ref));
  }
}
