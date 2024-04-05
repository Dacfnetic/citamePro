import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/reservation_page.dart';
import 'package:citame/providers/event_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectService extends ConsumerWidget {
  const SelectService({super.key, required this.trabajador});
  final Worker trabajador;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usuario user = ref.read(myBusinessStateProvider.notifier).getDatosUsuario();
    List<Service> serviciosSeleccionados2 = ref.watch(servicesProvider);
    List<ContenedorServicio> serviciosSeleccionados = serviciosSeleccionados2
        .map((e) => ContenedorServicio(servicio: e))
        .toList();
    List<Service> listaDeServicios =
        ref.watch(myBusinessStateProvider.notifier).getService();
    List<CajaDeServicios> servicios = listaDeServicios.map((servicio) {
      //Averiguar si es true o false
      bool estado = false;

      if (serviciosSeleccionados2.contains(servicio)) {
        estado = true;
      }

      //Retornar
      return CajaDeServicios(
        nombre: servicio.nombreServicio,
        idServicio: servicio.id,
        servicio: servicio,
        ref: ref,
        estadoInicial: estado,
        //precio: servicio.precio.toStringAsFixed(2),
        //duracion: servicio.duracion,
        //esDueno: true
      );
    }).toList();

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        ref.read(servicesProvider.notifier).limpiar();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Servicios',
              style: API.estiloJ16negro,
            ),
          ),
          body: SafeArea(
              child: Column(
            children: [
              TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.list_alt,
                        size: 28,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.check_box_rounded,
                        size: 28,
                      ),
                    )
                  ]),
              Expanded(
                child: TabBarView(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          'Selecciona los servicios que deseas agregar a tu cita',
                          style: API.estiloJ16negro,
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        SizedBox(height: 20),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            servicios.isNotEmpty
                                ? SizedBox(
                                    height: 300,
                                    child: ListView(
                                        shrinkWrap: true, children: servicios))
                                : Text(''),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(
                            'Lista de serivicios seleccionados para tu cita',
                            style: API.estiloJ16negro,
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              servicios.isNotEmpty
                                  ? SizedBox(
                                      height: 300,
                                      child: ListView(
                                          shrinkWrap: true,
                                          children: serviciosSeleccionados))
                                  : Text(''),
                              serviciosSeleccionados.isNotEmpty
                                  ? ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(eventsProvider.notifier)
                                            .inicializar(
                                                trabajador, DateTime.now());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReservationPage(
                                                        trabajador:
                                                            trabajador)));
                                      },
                                      child: Text(
                                        'siguiente',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : Text('')
                            ],
                          ),
                        ],
                      )),
                ]),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ContenedorServicio extends StatelessWidget {
  const ContenedorServicio({super.key, required this.servicio});
  final Service servicio;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(top: 10, right: 5, left: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(10)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              Text(
                servicio.nombreServicio,
                style: API.estiloJ16negro,
              ),
              Text(
                servicio.duracion,
                style: TextStyle(color: Colors.grey.withOpacity(0.8)),
              )
            ],
          ),
          Text(
            servicio.precio.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ]));
  }
}

class CajaDeServicios extends StatefulWidget {
  const CajaDeServicios({
    Key? key,
    required this.nombre,
    required this.idServicio,
    required this.servicio,
    required this.ref,
    required this.estadoInicial,
  }) : super(key: key);

  final String nombre;
  final String idServicio;
  final Service servicio;
  final bool estadoInicial;
  final WidgetRef ref;

  @override
  _CajaDeServiciosState createState() => _CajaDeServiciosState();
}

class _CajaDeServiciosState extends State<CajaDeServicios> {
  bool? isChecked;
  @override
  void initState() {
    isChecked = widget.estadoInicial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 2),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0,
                  3), // Cambia la posición de la sombra según tus necesidades
            ),
          ],
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.8))),
      child: CheckboxListTile(
        side: BorderSide(color: Colors.transparent),
        checkColor: Colors.black,
        //visualDensity: VisualDensity(horizontal: -4.0, vertical: -3.0),
        activeColor: Colors.transparent,

        title: Text(
          widget.nombre,
          style: API.estiloJ16negro,
        ),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            if (isChecked!) {
              widget.ref
                  .read(servicesProvider.notifier)
                  .anadir(widget.servicio, context, WidgetRef);
            } else {
              widget.ref
                  .read(servicesProvider.notifier)
                  .remover(widget.servicio);
            }
          });
        },
      ),
    );
  }
}
