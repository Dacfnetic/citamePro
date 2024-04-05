import 'dart:developer';

import 'package:citame/agenda/flutter_neat_and_clean_calendar.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/event_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationPage extends ConsumerWidget {
  ReservationPage({
    super.key,
    required this.trabajador,
  });

  final TextEditingController workerName = TextEditingController();
  final TextEditingController workerEmail = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final Worker trabajador;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(reRenderProvider);
    List<Service> serviciosSeleccionados2 = ref.watch(servicesProvider);

    print(TimeOfDay.now().format(context));

    List<NeatCleanCalendarEvent> eventList = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: signUpKey,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Calendar(
                    startOnMonday: true,
                    onMonthChanged: (value) {},
                    weekDays: ['Lu', 'Ma', 'Mi', 'JU', 'Vi', 'Sa', 'Do'],
                    eventsList: eventList,
                    isExpandable: true,
                    eventDoneColor: Colors.green,
                    selectedColor: Colors.pink,
                    onDateSelected: (value) async {
                      ref
                          .read(myBusinessStateProvider.notifier)
                          .setFecha(value);
                      ref.read(eventsProvider.notifier).inicializar(
                          trabajador,
                          ref
                              .read(myBusinessStateProvider.notifier)
                              .getFecha());
                      try {
                        TimeOfDay inicio =
                            await API.timePicker(context, 'Horario');
                        ref
                            .read(myBusinessStateProvider.notifier)
                            .setHora(inicio);
                        var duracion = 0.00;
                        for (var servicio in serviciosSeleccionados2) {
                          duracion = duracion + servicio.time;
                        }
                        final calculoDeHora =
                            (inicio.hour + (inicio.minute / 60)) + duracion;
                        final horaCalculada = calculoDeHora.truncate();

                        final minutoCalculado =
                            ((calculoDeHora - horaCalculada) * 60).round();
                        TimeOfDay horaFinal = TimeOfDay(
                            hour: horaCalculada, minute: minutoCalculado);
                        log(horaFinal.toString());
                        ref.read(eventsProvider.notifier).anadir(
                            inicio,
                            ref
                                .read(myBusinessStateProvider.notifier)
                                .getFecha(),
                            horaFinal);
                        ref
                            .read(myBusinessStateProvider.notifier)
                            .setHoraFinal(horaFinal);
                      } catch (e) {
                        return;
                      }
                    },
                    selectedTodayColor: Colors.red,
                    defaultDayColor: Colors.black,
                    todayColor: Colors.amber,
                    eventColor: null,
                    locale: 'es_ES',
                    todayButtonText: 'Hoy',
                    allDayEventText: 'Inicio',
                    multiDayEndText: 'Fin',
                    isExpanded: false,
                    expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                    //datePickerType: DatePickerType.date,
                    dayOfWeekStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 11),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            ref.read(myBusinessStateProvider.notifier).setCita(
                              fecha: ref
                                  .read(myBusinessStateProvider.notifier)
                                  .getFecha(),
                              horarioInicial: ref
                                  .read(myBusinessStateProvider.notifier)
                                  .getHora(),
                              horarioFinal: ref
                                  .read(myBusinessStateProvider.notifier)
                                  .getHoraFinal(),
                              servicios: [],
                            );
                            if (context.mounted) {
                              API.postCita(
                                  context,
                                  ref,
                                  ref
                                      .read(myBusinessStateProvider.notifier)
                                      .getCita(),
                                  prefs.getString('llaveDeUsuario')!,
                                  trabajador.idWorker,
                                  prefs.getString('negocioActual')!,
                                  trabajador.email);
                            }

                            // API.mensaje(context, 'Aviso',
                            //     'Solicitud de cita enviada, puedes acceder a el estado de la cita en la sección de citas que es el boton central de la barra inferor, también recibiras una notificación cuando esta sea aceptada.');
                          },
                          child: Text('Solicitar cita')),
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
      try {
        TimeOfDay inicio = await API.timePicker(context, 'Horario de inicio');
        if (context.mounted) {
          TimeOfDay fin = await API.timePicker(context, 'Horario de fin');
          ref
              .read(myBusinessStateProvider.notifier)
              .setDiasWorker(dia, inicio, fin);
          ref.read(reRenderProvider.notifier).reRender();
        }
      } catch (e) {
        return;
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 5, 15, 5),
      child: Column(
        children: [
          Container(
            //width: double.infinity,
            color: Colors.orange,
            child: Text(day.toUpperCase()),
          ),
          Column(children: obtenerHorario(day, horario)),
          ElevatedButton(
            onPressed: () async {
              getSchedule(day);
            },
            child: Text('Agregar horario'),
          ),
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
