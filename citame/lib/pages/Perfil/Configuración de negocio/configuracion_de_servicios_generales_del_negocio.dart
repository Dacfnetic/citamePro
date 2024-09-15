import 'package:citame/pages/Perfil/Crear%20negocio/Widgets/cuadro.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/caja_de_servicios.dart';
import 'package:citame/providers/duracion_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfiguracionDeServiciosGeneralesDelNegocio extends StatelessWidget {
  const ConfiguracionDeServiciosGeneralesDelNegocio(
      {super.key,
      required this.servicios,
      required this.validacion,
      required this.servicio,
      required this.precio,
      required this.ref});

  final List<CajaDeServicios> servicios;
  final GlobalKey<FormState> validacion;
  final TextEditingController servicio;
  final TextEditingController precio;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Menu',
                style: API.estiloJ24negro,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.monetization_on),
                color: Colors.amber,
                iconSize: 35,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
              )
            ],
          ),
        ),
        Text('Crea tu menú para que los clientes puedan darte su dinero',
            style: API.estiloJ14gris),
        ListView(
          shrinkWrap: true,
          children: [
            servicios.isNotEmpty
                ? SizedBox(
                    height: 300,
                    child: ListView(shrinkWrap: true, children: servicios))
                : Text(''),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () async {
            await showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (context2) => AlertDialog(
                content: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      right: -40,
                      top: -40,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context2).pop();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                    Form(
                      key: validacion,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Cuadro(control: servicio, texto: 'servicio'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Cuadro(control: precio, texto: 'precio'),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: CupertinoButton(
                                  // Display a CupertinoTimerPicker with hour/minute mode.
                                  onPressed: () {
                                    API.showDuracion(
                                      context,
                                      CupertinoTimerPicker(
                                        mode: CupertinoTimerPickerMode.hm,
                                        initialTimerDuration: duration,

                                        // This is called when the user changes the timer's
                                        // duration.
                                        onTimerDurationChanged:
                                            (Duration newDuration) {
                                          API.reRender(ref);
                                          ref
                                              .read(myBusinessStateProvider
                                                  .notifier)
                                              .setDuration(newDuration);
                                          print('jaa');
                                          ref
                                              .read(duracionProvider.notifier)
                                              .change(newDuration);
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Escoger duración',
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              child: const Text('confirmar'),
                              onPressed: () async {
                                if (validacion.currentState!.validate()) {
                                  Duration horario = ref
                                      .read(myBusinessStateProvider.notifier)
                                      .getDuration();
                                  String enviar = '';
                                  if (horario.inMinutes > 59) {
                                    if (horario.inHours > 1) {
                                      int minutos3 =
                                          (((horario.inMinutes / 60) -
                                                      horario.inHours) *
                                                  60)
                                              .round();
                                      String minutos =
                                          minutos3.toStringAsFixed(0);
                                      enviar =
                                          '${horario.inHours} horas con $minutos minutos';
                                    } else {
                                      int minutos3 =
                                          (((horario.inMinutes / 60) -
                                                      horario.inHours) *
                                                  60)
                                              .round();
                                      String minutos =
                                          minutos3.toStringAsFixed(0);
                                      enviar =
                                          '${horario.inHours} hr $minutos mins';
                                    }
                                  } else {
                                    enviar = '${horario.inMinutes} minutos';
                                  }
                                  final time = horario.inMinutes / 60;

                                  /*await API.postService(
                                  context,
                                  ref
                                      .read(
                                          myBusinessStateProvider
                                              .notifier)
                                      .getActualBusiness(),
                                  ref,
                                  servicio.text,
                                  double.parse(precio.text),
                                  enviar,
                                  '',
                                  time);*/
                                  ref.read(servicesProvider.notifier).anadir(
                                      Service(
                                        nombreServicio: servicio.text,
                                        imgPath: [],
                                        precio: double.parse(precio.text),
                                        descripcion: "descripcion",
                                        duracion: enviar,
                                        businessCreatedBy: ref
                                            .read(myBusinessStateProvider
                                                .notifier)
                                            .getActualBusiness(),
                                        id: "",
                                        time: time,
                                      ),
                                      context,
                                      ref);

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  /* ref
                                  .read(servicesProvider.notifier)
                                  .actualizar(ref
                                      .read(
                                          myBusinessStateProvider
                                              .notifier)
                                      .getService());
                              API.reRender(ref);*/
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text('Agregar servicio'),
        ),
      ],
    );
  }
}
