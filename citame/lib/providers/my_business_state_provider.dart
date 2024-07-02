import 'dart:convert';
import 'package:citame/models/business_model.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/user_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/pages/signin_page.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final myBusinessStateProvider =
    StateNotifierProvider<MyBusinessStateNotifier, List<Business>>((ref) {
  return MyBusinessStateNotifier();
});

class MyBusinessStateNotifier extends StateNotifier<List<Business>> {
  MyBusinessStateNotifier() : super([]);

  void setHorarioParaEnviar(Map entrada) {
    workerDaysAvailableEnviar.clear();
    List datos = [];
    for (var dia in dias) {
      for (var horas in entrada['horario'][dia]) {
        TimeOfDay inicio = horas['inicio'];
        TimeOfDay fin = horas['fin'];
        Map disponible = {
          'hora_inicial': inicio.hour,
          'minuto_inicial': inicio.minute,
          'hora_final': fin.hour,
          'minuto_final': fin.minute,
        };
        datos.add(disponible);
      }
      workerDaysAvailableEnviar[dia] = datos;
      datos = [];
    }
  }

  Map getHorarioParaEnviar() => workerDaysAvailableEnviar;

  void setDatosUsuario(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('googleId') == null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ));
    } else {
      user = Usuario(
          googleId: prefs.getString('googleId')!,
          userName: prefs.getString('userName')!,
          userEmail: prefs.getString('emailUser')!,
          avatar: prefs.getString('avatar')!);
    }
  }

  Usuario getDatosUsuario() => user!;

  void cargar(myBusiness) => state = myBusiness;

  // #region TODO: Mover a proveedor de workers
  void establecerWorkers(id, ref) async {
    workers = await API.getWorkers(id);
    API.reRender(ref);
  }

  List<Worker> obtenerWorkers() => workers;
  // #endregion

  void setService(id, ref) async {
    services = await API.getService(id);
    API.reRender(ref);
  }

  void setService2(response) async {
    final List<dynamic> serviceList = jsonDecode(response.body);
    //final List<dynamic> workerList = json.decode(workerList1);
    final List<Service> servicios = serviceList.map((servicio) {
      Service servicioActual = Service.fromJson(servicio);
      return servicioActual;
    }).toList();

    services = servicios;
  }

  List<Service> getService() => services;

  void setDias(dia, valor) {
    diasLaboralesGenerales[dia] = valor;
  }

  void limpiar() {
    state = [];
  }

  Map obtenerDias() {
    return diasLaboralesGenerales;
  }

  void setActualEmail(email) {
    actualEmail = email;
  }

  String getActualEmail() {
    return actualEmail;
  }

  void setActualBusiness(id) {
    actualBusiness = id;
  }

  String getActualBusiness() {
    return actualBusiness;
  }

  void eliminarHorario(dia, Map horario) {
    workerDaysAvailable[dia].remove(horario);
    print(workerDaysAvailable);
  }

  void cambiarHorario(dia, Map horario, TimeOfDay inicio, TimeOfDay fin) {
    //obtenerindice
    int index = workerDaysAvailable[dia].indexOf(horario);
    workerDaysAvailable[dia][index] = {'inicio': inicio, 'fin': fin};
  }

  void setHorarioGeneralDeTrabajador() =>
      workerDaysAvailable = Map.from(generalSchedule);

  void setDiasWorker(dia, TimeOfDay inicio, TimeOfDay fin) {
    workerDaysAvailable[dia].add({'inicio': inicio, 'fin': fin});
  }

  Map obtenerDiasWorker() {
    return workerDaysAvailable;
  }

  void copiarHorariosWorker(dia) {
    papelera = List.from(workerDaysAvailable[dia]);
  }

  void pegarHorariosWorker(dia) {
    workerDaysAvailable[dia] = List.from(papelera);
  }

  void borrarDiaWorker(dia) {
    workerDaysAvailable[dia] = [];
  }

  void setDiasGeneral(dia, TimeOfDay inicio, TimeOfDay fin) {
    generalSchedule[dia].add({'inicio': inicio, 'fin': fin});
  }

  Map obtenerDiasGeneral() => generalSchedule;

  void copiarHorariosGeneral(dia) {
    papelera = List.from(generalSchedule[dia]);
  }

  void pegarHorariosGeneral(dia) {
    generalSchedule[dia] = List.from(papelera);
  }

  void borrarDiaGeneral(dia) {
    generalSchedule[dia] = [];
  }

  void setCita({
    required DateTime fecha,
    required TimeOfDay horarioInicial,
    required TimeOfDay horarioFinal,
    required List servicios,
  }) {
    citaActual['dia'] = fecha.day;
    citaActual['mes'] = fecha.month;
    citaActual['year'] = fecha.year;
    citaActual['hora_inicial'] = horarioInicial.hour;
    citaActual['minuto_inicial'] = horarioInicial.minute;
    citaActual['hora_final'] = horarioFinal.hour;
    citaActual['minuto_final'] = horarioFinal.minute;
    citaActual['servicios'] = servicios;
  }

  Map getCita() {
    return citaActual;
  }

  void establecerDiasGeneral(Map entrada) {
    if (entrada.isNotEmpty) {
      for (var dia in dias) {
        generalSchedule[dia] = [];
        for (var periodo in entrada[dia]) {
          Map anadir = {
            'inicio': TimeOfDay(
                hour: periodo['hora_inicial'],
                minute: periodo['minuto_inicial']),
            'fin': TimeOfDay(
                hour: periodo['hora_final'], minute: periodo['minuto_final'])
          };
          generalSchedule[dia].add(anadir);
        }
      }
    }
  }

  void setFecha(DateTime fechaEscogida) {
    fecha = fechaEscogida;
  }

  DateTime getFecha() {
    return fecha;
  }

  void setHora(TimeOfDay horaEscogida) {
    hora = horaEscogida;
  }

  TimeOfDay getHora() {
    return hora;
  }

  void setHoraFinal(TimeOfDay horaEscogida) {
    horaFinal = horaEscogida;
  }

  TimeOfDay getHoraFinal() {
    return horaFinal;
  }

  void setDuration(dur) {
    duration = dur;
  }

  Duration getDuration() {
    return duration;
  }

  void setSocketState(valor) {
    socketConectado = valor;
  }

  bool getSocketState() {
    return socketConectado;
  }

  void setPage(entrada) {
    pagina = entrada;
  }

  Type getPage() {
    return pagina;
  }

  void sePuedenGuardarCambiosGeneralesCambio() {
    sePuedenGuardarCambiosGenerales = true;
  }

  void noSePuedenGuardarCambiosGeneralesCambio() {
    sePuedenGuardarCambiosGenerales = false;
  }

  bool getSePuedenGuardarCambiosGeneralesCambio() {
    return sePuedenGuardarCambiosGenerales;
  }
}

Map diasLaboralesGenerales = {
  'lunes': true,
  'martes': true,
  'miercoles': true,
  'jueves': true,
  'viernes': true,
  'sabado': true,
  'domingo': true,
};

Map workerDaysAvailable = {
  'lunes': [
    {
      'inicio': TimeOfDay(hour: 7, minute: 0),
      'fin': TimeOfDay(hour: 13, minute: 0)
    },
    {
      'inicio': TimeOfDay(hour: 14, minute: 0),
      'fin': TimeOfDay(hour: 17, minute: 0)
    }
  ],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};

Map generalSchedule = {
  'lunes': [
    {
      'inicio': TimeOfDay(hour: 7, minute: 0),
      'fin': TimeOfDay(hour: 13, minute: 0)
    },
    {
      'inicio': TimeOfDay(hour: 14, minute: 0),
      'fin': TimeOfDay(hour: 17, minute: 0)
    }
  ],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};

Map workerDaysAvailableEnviar = {
  'lunes': [
    {
      'hora_inicial': 7,
      'minuto_inicial': 0,
      'hora_final': 13,
      'minuto_final': 0,
    },
    {
      'inicio': TimeOfDay(hour: 14, minute: 0),
      'fin': TimeOfDay(hour: 17, minute: 0)
    }
  ],
  'martes': [],
  'miercoles': [],
  'jueves': [],
  'viernes': [],
  'sabado': [],
  'domingo': [],
};

Map citaActual = {
  'dia': '',
  'mes': '',
  'year': '',
  'servicios': [],
  'hora_inicial': '',
  'minuto_inicial': '',
  'hora_final': '',
  'minuto_final': '',
};

DateTime fecha = DateTime.now();

TimeOfDay hora = TimeOfDay.now();
TimeOfDay horaFinal = TimeOfDay.now();
List<Worker> workers = [];
List<Service> services = [];
List papelera = [];

String actualBusiness = '';

String actualEmail = '';

Duration duration = const Duration(hours: 0, minutes: 30);

bool socketConectado = false;

Usuario? user;

Type pagina = HomePage().runtimeType;

bool sePuedenGuardarCambiosGenerales = false;

List<String> dias = [
  'lunes',
  'martes',
  'miercoles',
  'jueves',
  'viernes',
  'sabado',
  'domingo'
];
