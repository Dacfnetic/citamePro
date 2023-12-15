import 'dart:convert';
import 'dart:io';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/providers/my_actual_business_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
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
  final GlobalKey<FormState> signUpKey =
      GlobalKey<FormState>(); //llave global del form para validaciones

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String ruta = ref.watch(imgProvider);
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
                          color: Color(0x4d39d2c0),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff39d2c0),
                            width: 2,
                          ),
                        ),
                        child: SizedBox(
                          height: 90,
                          width: 90,
                          child: TextButton(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: ruta != ''
                                    ? Image.file(
                                        File(ruta),
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
                                Text(
                                  "Albert Einstein",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                    onPressed: () {}, child: Text("edit")),
                              ],
                            ),
                            Text("Einstein@gmail.com"),
                            Text(
                              "Barbero",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            )
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
                            var enviar = jsonEncode(horas.toJson().toString());
                            if (signUpKey.currentState!.validate()) {
                              if (context.mounted) {
                                API.postWorker(
                                    'Diego',
                                    'dacf9x@gmail.com',
                                    ref.read(imgProvider),
                                    500.50,
                                    enviar,
                                    ref.read(actualBusinessProvider),
                                    prefs.getString('emailUser')!,
                                    context,
                                    'Presidente');
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
      TimeOfDay inicio =
          await API.timePicker(context, 'Horario de inicio').then();
      if (context.mounted) {
        TimeOfDay fin = await API.timePicker(context, 'Horario de fin');
        ref
            .read(myBusinessStateProvider.notifier)
            .setDiasWorker(dia, inicio, fin);
        ref.read(reRenderProvider.notifier).reRender();
      }
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
      margin: EdgeInsets.fromLTRB(0, 10, 15, 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.cyan,
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
                  color: Colors.cyan,
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
                  color: Colors.cyan,
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
                  color: Colors.cyan,
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
                  color: Colors.cyan,
                ),
              )
            ],
          )

          /*TextButton(
            onPressed: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_clock),
                Text(
                  'Hora',
                  style: API.estiloJ14gris,
                ),
              ],
            ),
          ),
        */
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
