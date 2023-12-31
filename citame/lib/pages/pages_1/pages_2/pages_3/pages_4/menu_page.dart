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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

    List<Service> listaDeServicios =
        ref.watch(myBusinessStateProvider.notifier).getService();
    List<CajaDeServicios> servicios = listaDeServicios
        .map((servicio) => CajaDeServicios(
            nombre: servicio.nombreServicio,
            precio: servicio.precio.toStringAsFixed(2),
            duracion: servicio.duracion,
            esDueno: true))
        .toList();
    ReRenderNotifier reRender = ref.read(reRenderProvider.notifier);
    List<Worker> workers =
        ref.watch(myBusinessStateProvider.notifier).obtenerWorkers();
    List<WorkerBox> trabajadores = workers
        .map((e) => WorkerBox(
              worker: e,
              ref: ref,
              imagen: e.imgPath[0],
              isDueno: true,
            ))
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(children: [
            TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    icon: Icon(Icons.menu_book, size: 30),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    child: Text('Jornada', style: TextStyle(fontSize: 14)),
                  ),
                  Tab(
                    icon: Icon(Icons.group, size: 30),
                    child: Text('Trabajadores', style: TextStyle(fontSize: 14)),
                  )
                ]),
            Expanded(
                child: TabBarView(children: [
              Column(
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
                  Text(
                      'Crea tu menú para que los clientes puedan darte su dinero',
                      style: API.estiloJ14gris),
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
                                      child: Cuadro(
                                          control: servicio, texto: 'servicio'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Cuadro(
                                          control: precio, texto: 'precio'),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CupertinoButton(
                                            // Display a CupertinoTimerPicker with hour/minute mode.
                                            onPressed: () {
                                              showDuracion(
                                                CupertinoTimerPicker(
                                                  mode: CupertinoTimerPickerMode
                                                      .hm,
                                                  initialTimerDuration:
                                                      duration,

                                                  // This is called when the user changes the timer's
                                                  // duration.
                                                  onTimerDurationChanged:
                                                      (Duration newDuration) {
                                                    API.reRender(ref);
                                                    ref
                                                        .read(
                                                            myBusinessStateProvider
                                                                .notifier)
                                                        .setDuration(
                                                            newDuration);
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
                                          if (validacion.currentState!
                                              .validate()) {
                                            Duration horario = ref
                                                .read(myBusinessStateProvider
                                                    .notifier)
                                                .getDuration();
                                            String enviar = '';
                                            if (horario.inMinutes > 59) {
                                              if (horario.inHours > 1) {
                                                int minutos3 =
                                                    (((horario.inMinutes / 60) -
                                                                horario
                                                                    .inHours) *
                                                            60)
                                                        .round();
                                                String minutos =
                                                    minutos3.toStringAsFixed(0);
                                                enviar =
                                                    '${horario.inHours} horas con $minutos minutos';
                                              } else {
                                                int minutos3 =
                                                    (((horario.inMinutes / 60) -
                                                                horario
                                                                    .inHours) *
                                                            60)
                                                        .round();
                                                String minutos =
                                                    minutos3.toStringAsFixed(0);
                                                enviar =
                                                    '${horario.inHours} hr $minutos mins';
                                              }
                                            } else {
                                              enviar =
                                                  '${horario.inMinutes} minutos';
                                            }

                                            print(horario);
                                            await API.postService(
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
                ],
              ),
              ListView(
                children: [
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
                ],
              ),
              ListView(
                children: [
                  Text('Perfiles', style: API.estiloJ24negro),
                  Text(
                      'Crea los perfiles de tu personal para que tus clientes puedan conocerlos.',
                      style: API.estiloJ14gris),
                  workers.isNotEmpty
                      ? Expanded(
                          child: ListView(
                              shrinkWrap: true, children: trabajadores))
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
              )
            ]))
          ]),
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
    required this.esDueno,
  });
  final bool esDueno;
  final String nombre;
  final String precio;
  final String duracion;
  @override
  Widget build(BuildContext context) {
    if (esDueno) {
      return Slidable(
        dragStartBehavior: DragStartBehavior.start,
        startActionPane: ActionPane(motion: BehindMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.delete,
            backgroundColor: Colors.red,

            // borderRadius: BorderRadius.circular(12),
          ),
        ]),
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            //borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.8),
              //borderRadius: BorderRadius.circular(12),
              color: Colors.white),
          //margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.cut, size: 32),
                  )),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 30),
                  //padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        duracion,
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              //Spacer(flex: 3),
              Text(precio,
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          color: Colors.white, // Color de fondo del Container
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(2),
              child: Icon(Icons.cut, size: 35),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 30),
                //padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 6),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      duracion,
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            //Spacer(flex: 3),
            Text(precio, style: TextStyle(fontSize: 20, color: Colors.green)),
          ],
        ),
      );
    }
  }
}
