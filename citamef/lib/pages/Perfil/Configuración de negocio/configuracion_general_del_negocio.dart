import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/boton_para_guardar_configuracion_del_negocio.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/caja_de_servicios.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/configuracion_de_horario_general_del_negocio.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/configuracion_de_servicios_generales_del_negocio.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/registro_de_trabajadores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfiguracionGeneralDelNegocio extends StatelessWidget {
  const ConfiguracionGeneralDelNegocio(
      {super.key,
      required this.servicios,
      required this.validacion,
      required this.servicio,
      required this.precio,
      required this.horario,
      required this.workers,
      required this.trabajadores,
      required this.horas,
      required this.ref});

  final List<CajaDeServicios> servicios;
  final GlobalKey<FormState> validacion;
  final TextEditingController servicio;
  final TextEditingController precio;
  final Map horario;
  final List<Worker> workers;
  final List<WorkerBox> trabajadores;
  final Schedule horas;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('configuracion',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ),
        body: SafeArea(
          child: Column(children: [
            TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    icon: Icon(Icons.list, size: 30),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.access_time,
                      size: 30,
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.group, size: 30),
                  )
                ]),
            Expanded(
                child: TabBarView(children: [
              ConfiguracionDeServiciosGeneralesDelNegocio(
                  servicios: servicios,
                  validacion: validacion,
                  servicio: servicio,
                  precio: precio,
                  ref: ref),
              ConfiguracionDeHorarioGeneralDelNegocio(
                  horario: horario, ref: ref),
              RegistroDeTrabajadores(
                  workers: workers, trabajadores: trabajadores, ref: ref)
            ]))
          ]),
        ),
        floatingActionButton:
            BotonParaGuardarConfiguracionDelNegocio(ref: ref, horas: horas),
      ),
    );
  }
}
