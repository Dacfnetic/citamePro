import 'dart:convert';
import 'dart:io';
import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/providers/my_actual_business_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/providers/workers_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInsidePage extends ConsumerWidget {
  ProfileInsidePage({
    super.key,
  });

  final TextEditingController workerName = TextEditingController();
  final TextEditingController workerEmail = TextEditingController();
  final TextEditingController workerJob = TextEditingController();
  final TextEditingController workerSalary = TextEditingController();
  final TextEditingController workerCel = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpKey =
      GlobalKey<FormState>(); //llave global del form para validaciones

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    File ruta = ref.watch(imgProvider);
    Map horario =
        ref.watch(myBusinessStateProvider.notifier).obtenerDiasWorker();
    Schedule horas = Schedule(horario: horario);

    print(TimeOfDay.now().format(context));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: signUpKey,
          child: Container(
            color: Color.fromRGBO(240, 240, 240, 1),
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                  //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                    )
                  ]),

                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        child: SizedBox(
                          height: 90,
                          width: 90,
                          child: TextButton(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: ruta.path != ''
                                    ? Image.file(
                                        ruta,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Text('')),
                            onPressed: () {
                              API.pickImageFromGallery(ref);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                workerName.text == ''
                                    ? Text(
                                        "Albert Einstein",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        workerName.text,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                TextButton(
                                    onPressed: () async {
                                      await showDialog<void>(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: <Widget>[
                                              Positioned(
                                                right: -40,
                                                top: -40,
                                                child: InkResponse(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    child: Icon(Icons.close),
                                                  ),
                                                ),
                                              ),
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Cuadro(
                                                          control: workerName,
                                                          texto:
                                                              'Nombre del trabajador'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Cuadro(
                                                          control: workerEmail,
                                                          texto:
                                                              'Email del trabajador'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Cuadro(
                                                          control: workerJob,
                                                          texto:
                                                              'Puesto del trabajador'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Cuadro(
                                                          control: workerSalary,
                                                          texto:
                                                              'Salario del trabajador'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Cuadro(
                                                          control: workerCel,
                                                          texto:
                                                              'Celular del trabajador'),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: ElevatedButton(
                                                        child: const Text(
                                                            'Submitß'),
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _formKey
                                                                .currentState!
                                                                .save();
                                                            Navigator.pop(
                                                                context);
                                                            API.reRender(ref);
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
                                    child: Text("Editar")),
                              ],
                            ),
                            workerEmail.text == ''
                                ? Text("Einstein@gmail.com")
                                : Text(workerEmail.text),
                            workerJob.text == ''
                                ? Text("Barbero")
                                : Text(
                                    workerJob.text,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                            workerCel.text == ''
                                ? Text("0000-0000")
                                : Text(
                                    workerCel.text,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: Column(
                    children: [
                      ContenedorDeHorario(
                          horario: horario, day: 'lunes', ref: ref),
                      ContenedorDeHorario(
                          horario: horario, day: 'martes', ref: ref),
                      ContenedorDeHorario(
                          horario: horario, day: 'miercoles', ref: ref),
                      ContenedorDeHorario(
                          horario: horario, day: 'jueves', ref: ref),
                      ContenedorDeHorario(
                          horario: horario, day: 'viernes', ref: ref),
                      ContenedorDeHorario(
                          horario: horario, day: 'sabado', ref: ref),
                      ContenedorDeHorario(
                          horario: horario, day: 'domingo', ref: ref),
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            //var enviar = jsonEncode(horas.toJson().toString());

                            var horarioLibre = '';
                            ref
                                .read(myBusinessStateProvider.notifier)
                                .setHorarioParaEnviar(horas.toJson());
                            Map enviar = ref
                                .read(myBusinessStateProvider.notifier)
                                .getHorarioParaEnviar();
                            if (signUpKey.currentState!.validate()) {
                              if (context.mounted) {
                                /*API.postImagen2(
                                  workerName.text,
                                  workerEmail.text,
                                  ref.read(imgProvider),
                                  double.parse(workerSalary.text),
                                  enviar,
                                  ref.read(actualBusinessProvider),
                                  ref
                                      .read(myBusinessStateProvider.notifier)
                                      .getActualBusiness(),
                                  prefs.getString('emailUser')!,
                                  context,
                                  workerJob.text,
                                  horarioLibre,
                                  workerCel.text,
                                );*/
                                ref.read(workersProvider.notifier).anadir(
                                    Worker(
                                        name: workerName.text,
                                        email: workerEmail.text,
                                        imgPath: [ref.read(imgProvider)],
                                        imagen1: ref.read(imgProvider).path,
                                        salary: double.parse(workerSalary.text),
                                        horario: enviar,
                                        status: false,
                                        id: "",
                                        idWorker: "",
                                        puesto: workerJob.text,
                                        horarioDisponible: {},
                                        celular: int.parse(workerCel.text)));
                                //Escribir lo que pasa despues del post
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text('Agregar trabajador')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContenedorDeHorario extends StatelessWidget {
  const ContenedorDeHorario({
    super.key,
    required this.horario,
    required this.day,
    required this.ref,
  });
  final String day;
  final Map horario;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    List<Horario> obtenerHorario(String dia, Map horas) {
      print(TimeOfDay.now().format(context));
      List<dynamic> aProcesar = horas[dia];
      int contador = -1;
      List<Horario> retornar = aProcesar.map((turno) {
        contador += 1;
        return Horario(
          ref: ref,
          horario: turno,
          turno: contador + 1,
          dia: dia,
        );
      }).toList();
      contador = -1;

      return retornar;
    }

    void getSchedule(String dia) async {
      TimeOfDay inicio = await API.timePicker(context, 'Horario de inicio');

      TimeOfDay fin = await API.timePicker(context, 'Horario de fin');
      ref
          .read(myBusinessStateProvider.notifier)
          .setDiasWorker(dia, inicio, fin);
      ref.read(reRenderProvider.notifier).reRender();
    }

    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Color de la sombra
              spreadRadius: 2, // Extensión de la sombra
              blurRadius: 2, // Desenfoque de la sombra
              offset: Offset(0, 1), // Desplazamiento de la sombra
            ),
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(5, 10, 15, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
          ),
          Column(children: obtenerHorario(day, horario)),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  getSchedule(day);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .copiarHorariosWorker(day);
                  API.mensaje2(context, 'Horario copiado');
                },
                child: Icon(
                  Icons.copy,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .pegarHorariosWorker(day);
                  ref.read(reRenderProvider.notifier).reRender();
                },
                child: Icon(
                  Icons.paste,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .borrarDiaWorker(day);
                  ref.read(reRenderProvider.notifier).reRender();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ContenedorDeHorario2 extends StatelessWidget {
  const ContenedorDeHorario2({
    super.key,
    required this.horario,
    required this.day,
    required this.ref,
  });
  final String day;
  final Map horario;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    List<Horario> obtenerHorario(String dia, Map horas) {
      print(TimeOfDay.now().format(context));
      List<dynamic> aProcesar = horas[dia];
      int contador = -1;
      List<Horario> retornar = aProcesar.map((turno) {
        contador += 1;
        return Horario(
          ref: ref,
          horario: turno,
          turno: contador + 1,
          dia: dia,
        );
      }).toList();
      contador = -1;

      return retornar;
    }

    void getSchedule(String dia) async {
      TimeOfDay inicio = await API.timePicker(context, 'Horario de inicio');

      TimeOfDay fin = await API.timePicker(context, 'Horario de fin');
      ref
          .read(myBusinessStateProvider.notifier)
          .setDiasGeneral(dia, inicio, fin);
      ref.read(reRenderProvider.notifier).reRender();
    }

    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Color de la sombra
              spreadRadius: 2, // Extensión de la sombra
              blurRadius: 2, // Desenfoque de la sombra
              offset: Offset(0, 1), // Desplazamiento de la sombra
            ),
          ],
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12)),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(5, 10, 15, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ],
            ),
          ),
          Column(children: obtenerHorario(day, horario)),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  getSchedule(day);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .copiarHorariosGeneral(day);
                  API.mensaje2(context, 'Horario copiado');
                },
                child: Icon(
                  Icons.copy,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .pegarHorariosGeneral(day);
                  ref.read(reRenderProvider.notifier).reRender();
                },
                child: Icon(
                  Icons.paste,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref
                      .read(myBusinessStateProvider.notifier)
                      .borrarDiaGeneral(day);
                  ref.read(reRenderProvider.notifier).reRender();
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Horario extends StatelessWidget {
  const Horario({
    super.key,
    required this.horario,
    required this.turno,
    required this.dia,
    required this.ref,
  });

  final Map horario;
  final int turno;
  final String dia;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    ref.watch(reRenderProvider);
    int horaInicial = horario['inicio'].hourOfPeriod;
    int minutoInicial = horario['inicio'].minute;
    String mI = minutoInicial.toString();
    if (minutoInicial < 10) {
      mI = '0$mI';
    }
    DayPeriod periodoInicial = horario['inicio'].period;
    String pI = periodoInicial.name;

    int horaFinal = horario['fin'].hourOfPeriod;
    int minutoFinal = horario['fin'].minute;
    String mF = minutoFinal.toString();
    if (minutoFinal < 10) {
      mF = '0$mF';
    }
    DayPeriod periodoFinal = horario['fin'].period;
    String pF = periodoFinal.name;
    return Row(children: [
      Expanded(
          child: TextButton(
        onPressed: () async {
          API.cambiarHorario(context, ref, dia, horario);
          ref.read(reRenderProvider.notifier).reRender();
        },
        child: Text(
          'Horario $turno',
          textAlign: TextAlign.center,
        ),
      )),
      Expanded(
          child: Text(
        '$horaInicial:$mI $pI',
        textAlign: TextAlign.center,
      )),
      Expanded(
          child: Text(
        '$horaFinal:$mF $pF',
        textAlign: TextAlign.center,
      )),
    ]);
  }
}
