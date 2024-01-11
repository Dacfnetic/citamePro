import 'package:citame/agenda/neat_and_clean_calendar_event.dart';
import 'package:citame/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsProvider =
    StateNotifierProvider<EventsNotifier, List<NeatCleanCalendarEvent>>((ref) {
  return EventsNotifier();
});

class EventsNotifier extends StateNotifier<List<NeatCleanCalendarEvent>> {
  EventsNotifier() : super([]);

  void anadir(inicial, fecha, fin) {
    String des = state[state.length - 1].description;
    if (des == 'S)x¿4l') {
      state.removeLast();
    }
    state = [
      ...state,
      NeatCleanCalendarEvent(
        'Tu cita',
        startTime: DateTime(
            fecha.year, fecha.month, fecha.day, inicial.hour, inicial.minute),
        endTime:
            DateTime(fecha.year, fecha.month, fecha.day, fin.hour, fin.minute),
        color: Colors.orange,
        description: 'S)x¿4l',
      )
    ];
    /*List<double> x = [];
    x = lista.where((servicio) => servicio.nombreServicio != entrada.data);
    servicios = List.from(x);*/
  }

  void remover(entrada) {
    //List<Service> nueva = state.where((element) => element != entrada).toList();

    //state = nueva;
  }

  void inicializar(trabajador, dia) {
    //Tomar en cuenta solo los días posteriores o iguales al dia actual.
    DateTime hoy = DateTime.now();

    //Comida
    var contador = 1;
    bool continua = true;
    List diasDelMes = [];
    while (continua) {
      diasDelMes.add('$contador/${dia.month}/${dia.year}');
      contador++;
      DateTime ahora = DateTime(dia.year, dia.month, contador);
      if (ahora.month != dia.month) {
        continua = false;
      }
    }
    Map esclavo = trabajador.horarioDisponible;
    List diasOcupado = esclavo['diasConCitas'];
    List diasConCita = [];

    if (diasOcupado.isNotEmpty) {
      for (var dia in diasOcupado) {
        diasConCita.add(dia['fecha']);
      }
    }
    List<NeatCleanCalendarEvent> aDevolver2 = [];
    for (var day in diasDelMes) {
      List<String> espliteado = day.split('/');
      String spliteado2 = espliteado[0];
      int este = int.parse(spliteado2);
      DateTime ahora = DateTime(dia.year, dia.month, este);
      int diaActual = ahora.weekday;
      String diaEnLetras = '';
      switch (diaActual) {
        case 1:
          diaEnLetras = 'lun';
          break;
        case 2:
          diaEnLetras = 'ma';
          break;
        case 3:
          diaEnLetras = 'mie';
          break;
        case 4:
          diaEnLetras = 'jue';
          break;
        case 5:
          diaEnLetras = 'vie';
          break;
        case 6:
          diaEnLetras = 'sab';
          break;
        case 7:
          diaEnLetras = 'dom';
          break;
      }
      final index = diasConCita.indexOf(day);
      if (index != -1) {
        Map horarios = diasOcupado[index];
        List periodosDisponibles = horarios['HorarioDisp'];
        List<NeatCleanCalendarEvent> aDevolver = [];
        aDevolver = periodosDisponibles.map((periodo) {
          final horaInicial = periodo['HoraInicial'].truncate();
          final minutoInicial =
              ((periodo['HoraInicial'] - periodo['HoraInicial'].truncate()) *
                      60)
                  .round();
          final horaFinal = periodo['HoraFinal'].truncate();
          final minutoFinal =
              ((periodo['HoraFinal'] - periodo['HoraFinal'].truncate()) * 60)
                  .round();
          return NeatCleanCalendarEvent(
            'Disponible',
            startTime:
                DateTime(dia.year, dia.month, este, horaInicial, minutoInicial),
            endTime:
                DateTime(dia.year, dia.month, este, horaFinal, minutoFinal),
            color: Colors.green,
            description: 'Disponible para cumplir sus deseos',
          );
        }).toList();
        aDevolver2.addAll(aDevolver);
      } else {
        List<NeatCleanCalendarEvent> aDevolver = [];
        for (var periodo in esclavo[diaEnLetras]) {
          final horaInicial = periodo['HoraInicial'].truncate();
          final minutoInicial =
              ((periodo['HoraInicial'] - periodo['HoraInicial'].truncate()) *
                      60)
                  .round();
          final horaFinal = periodo['HoraFinal'].truncate();
          final minutoFinal =
              ((periodo['HoraFinal'] - periodo['HoraFinal'].truncate()) * 60)
                  .round();
          NeatCleanCalendarEvent nuevo = NeatCleanCalendarEvent(
            'Disponible',
            startTime:
                DateTime(dia.year, dia.month, este, horaInicial, minutoInicial),
            endTime:
                DateTime(dia.year, dia.month, este, horaFinal, minutoFinal),
            color: Colors.green,
            description: 'Disponible para cumplir sus deseos',
          );
          aDevolver2.add(nuevo);
        }
      }
    }
    state = aDevolver2;
  }

  void limpiar() {
    state = [];
  }

  /*void eliminar(entrada) {
    var index = state.where((element) => element.data)
    state = state.removeAt(index);
  }*/
}

List<double> servicios = [];
