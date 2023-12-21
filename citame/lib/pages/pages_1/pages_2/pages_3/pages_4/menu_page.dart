import 'dart:typed_data';
import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/pages_5/profile_inside.dart';
import 'package:citame/providers/duracion_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/cupertino.dart';
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
    void showDuracion(Widget child) async {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
      API.reRender(ref);
    }

    String horaDeDuracion = ref.watch(duracionProvider).toString();
    bool caca = ref.watch(reRenderProvider);
    List<Service> listaDeServicios =
        ref.watch(myBusinessStateProvider.notifier).getService();
    List<CajaDeServicios> servicios = listaDeServicios
        .map((servicio) => CajaDeServicios(
            nombre: servicio.nombreServicio,
            precio: servicio.precio.toStringAsFixed(2),
            duracion: servicio.duracion))
        .toList();
    ReRenderNotifier reRender = ref.read(reRenderProvider.notifier);
    List<Worker> workers =
        ref.watch(myBusinessStateProvider.notifier).obtenerWorkers();
    List<WorkerBox> trabajadores = workers
        .map((e) => WorkerBox(worker: e, ref: ref, imagen: e.imgPath[0]))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Color.fromRGBO(240, 240, 240, 1),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Text('Menu', style: API.estiloJ24negro)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.construction_sharp),
                    color: Colors.black,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                  )
                ],
              ),
              Text('Crea tu menú para que los clientes puedan darte su dinero',
                  style: API.estiloJ14gris),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: 01),
                    Expanded(
                        child: Text(
                      'Servicios',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Precios',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Duracion',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              servicios.isNotEmpty
                  ? ListView(shrinkWrap: true, children: servicios)
                  : Text(''),
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
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Cuadro(
                                      control: servicio, texto: 'servicio'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child:
                                      Cuadro(control: precio, texto: 'precio'),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: CupertinoButton(
                                        // Display a CupertinoTimerPicker with hour/minute mode.
                                        onPressed: () {
                                          showDuracion(
                                            CupertinoTimerPicker(
                                              mode: CupertinoTimerPickerMode.hm,
                                              initialTimerDuration: duration,

                                              // This is called when the user changes the timer's
                                              // duration.
                                              onTimerDurationChanged:
                                                  (Duration newDuration) {
                                                API.reRender(ref);
                                                ref
                                                    .read(
                                                        myBusinessStateProvider
                                                            .notifier)
                                                    .setDuration(newDuration);
                                                print('jaa');
                                                ref
                                                    .read(duracionProvider
                                                        .notifier)
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
                                            .read(myBusinessStateProvider
                                                .notifier)
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
                                                '   ${horario.inHours} horas con $minutos minutos';
                                          } else {
                                            int minutos3 =
                                                (((horario.inMinutes / 60) -
                                                            horario.inHours) *
                                                        60)
                                                    .round();
                                            String minutos =
                                                minutos3.toStringAsFixed(0);
                                            enviar =
                                                '   ${horario.inHours} hora con $minutos minutos';
                                          }
                                        } else {
                                          enviar =
                                              '   ${horario.inMinutes} minutos';
                                        }

                                        print(horario);
                                        await API.postService(
                                            context,
                                            ref
                                                .read(myBusinessStateProvider
                                                    .notifier)
                                                .getActualBusiness(),
                                            ref,
                                            servicio.text,
                                            double.parse(precio.text),
                                            enviar,
                                            '');
                                        if (context.mounted) {
                                          API.reRender(ref);
                                          Navigator.pop(context);
                                        }
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
              Text('Jornada de atención', style: API.estiloJ24negro),
              Text(
                'Días de atención general del negocio, dentro de cada perfíl de trabajador puedes escoger que días trabaja.',
                style: API.estiloJ14gris,
              ),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['lunes'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('lunes', value);
                    reRender.reRender();
                  },
                  title: Text('Lunes')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['martes'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('martes', value);
                    reRender.reRender();
                  },
                  title: Text('Martes')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['miercoles'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('miercoles', value);
                    reRender.reRender();
                  },
                  title: Text('Miércoles')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['jueves'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('jueves', value);
                    reRender.reRender();
                  },
                  title: Text('Jueves')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['viernes'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('viernes', value);
                    reRender.reRender();
                  },
                  title: Text('Viernes')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['sabado'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('sabado', value);
                    reRender.reRender();
                  },
                  title: Text('Sábado')),
              CheckboxListTile(
                  value: ref
                      .watch(myBusinessStateProvider.notifier)
                      .obtenerDias()['domingo'],
                  onChanged: (value) {
                    ref
                        .read(myBusinessStateProvider.notifier)
                        .setDias('domingo', value);
                    reRender.reRender();
                  },
                  title: Text('Domingo')),
              Text('Perfiles', style: API.estiloJ24negro),
              Text(
                  'Crea los perfiles de tu personal para que tus clientes puedan conocerlos.',
                  style: API.estiloJ14gris),
              workers.isNotEmpty
                  ? ListView(shrinkWrap: true, children: trabajadores)
                  : Container(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileInsidePage(),
                      ));
                },
                icon: Icon(Icons.plus_one),
                label: Text('Agregar más'),
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CajaDeServicios extends StatelessWidget {
  const CajaDeServicios({
    super.key,
    required this.nombre,
    required this.precio,
    required this.duracion,
  });
  final String nombre;
  final String precio;
  final String duracion;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(nombre),
        Text(precio),
        Text(duracion),
      ],
    );
  }
}
