import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:citame/providers/event_provider.dart';
import 'package:citame/providers/own_business_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/firebase_options.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/Perfil/Crear%20negocio/business_registration_page.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

String serverUrl = API.server;
FirebaseAuth auth = FirebaseAuth.instance;
String actualCat = 'Doctores y dentistas';

String categoriaABuscar = '';
/*
IO.Socket socket = IO.io('http://win.citame.store/', <String, dynamic>{
  "transports": ["websocket"],
  "autoConnect": false,
});*/
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

abstract class API {
  //static String server =
  //    'http://ec2-18-226-172-244.us-east-2.compute.amazonaws.com:4000';
  static String server = 'https://laptopcris.citame.store';

  static Future<Map> guardarConfiguracionGeneral(
      BuildContext context,
      String businessId,
      Map horario,
      List<Service> servicios,
      List<Worker> trabajadores,
      WidgetRef ref) async {
    List paraEnviar = [];
    String horarioParaEnviar = jsonEncode(horario);
    for (var trabajador in trabajadores) {
      Map agregarALaLista = trabajador.toJson();
      agregarALaLista['horario'] = jsonEncode(trabajador.horario);
      agregarALaLista['imgPath'] = trabajador.imgPath[0].path;
      paraEnviar.add(jsonEncode(agregarALaLista));
    }
    String enviar = paraEnviar.toString();

    List paraEnviar2 = [];
    for (var serv in servicios) {
      Map agregarALaLista = serv.toJson();
      paraEnviar2.add(jsonEncode(agregarALaLista));
    }
    String enviar2 = paraEnviar2.toString();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/business/saveChangesFromBusiness'));

    for (var trabajador in trabajadores) {
      request.files.add(await http.MultipartFile.fromPath(
          'imagen', trabajador.imgPath[0].path));
    }

    request.fields['businessId'] = businessId;
    request.fields['requestedServices'] = enviar2;
    request.fields['horario'] = horarioParaEnviar;
    request.fields['requestedWorkers'] = enviar;

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      log("Result: ${response.statusCode}");
      Map contenido = jsonDecode(response.body);
      ref
          .read(ownBusinessProvider.notifier)
          .actualizarUnNegocio(contenido, context, ref);
      log(contenido.toString());
      return contenido;
    }

    throw Exception('Failed to add item');
  }

  static Future<String> postWorker(
      String name,
      String workerEmail,
      File imgPath,
      double salary,
      Map horario,
      String businessName,
      String businessId,
      String email,
      BuildContext context,
      String puesto,
      String horarioLibre,
      String celular,
      String destiny) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/workers/create'));

    request.files
        .add(await http.MultipartFile.fromPath('imagen', imgPath.path));

    request.fields['destiny'] = destiny;
    request.fields['name'] = name;
    request.fields['email'] = workerEmail;
    request.fields['businessName'] = businessName;
    request.fields['id'] = businessId;
    request.fields['businessEmail'] = email;
    request.fields['salary'] = salary.toString();
    request.fields['horario'] = horario.toString();
    request.fields['horarioLibre'] = horarioLibre;
    request.fields['status'] = false.toString();
    request.fields['puesto'] = puesto;
    request.fields['celular'] = celular;

    var response = await request.send();

    if (response.statusCode == 201) {
      if (context.mounted) {
        API.mensaje(context, 'Aviso', 'La solicitud fue enviada al trabajador');
        return 'Todo ok';
      }
    }
    if (response.statusCode == 202) {
      if (context.mounted) {
        API.mensaje(
            context, 'Aviso', 'El correo no está registrado en la aplicación');
        return 'Todo ok';
      }
    }
    if (response.statusCode == 203) {
      if (context.mounted) {
        API.mensaje(
            context, 'Aviso', 'El correo ya está asignado a este negocio');
        return 'Todo ok';
      }
    }

    throw Exception('Failed to add item');
  }

  static Future<String> deleteBusiness(String businessId) async {
    final response =
        await http.delete(Uri.parse('$serverUrl/api/business/delete'),
            headers: {'Content-Type': 'application/json'},
            body: utf8.encode(jsonEncode({
              'businessId': businessId,
            })));

    if (response.statusCode == 200) {
      // emitir(businessId);
      return 'borrado';
    }

    throw Exception('Failed to add item');
  }

  static Future<String> deleteWorkerInBusiness(
      String idBusiness, String id, String idWorker) async {
    final response =
        await http.delete(Uri.parse('$serverUrl/api/workers/delete'),
            headers: {'Content-Type': 'application/json'},
            body: utf8.encode(jsonEncode({
              'idBusiness': idBusiness,
              'idWorker': idWorker,
            })));

    if (response.statusCode == 200) {
      API.updateWorkersInBusinessByDelete(idBusiness, idWorker);
      return 'borrado';
    }

    throw Exception('Failed to add item');
  }

  static Future<String> updateWorkersInBusinessByDelete(
      String idBusiness, String idWorker) async {
    final response =
        await http.put(Uri.parse('$serverUrl/api/business/workerupdate'),
            headers: {'Content-Type': 'application/json'},
            body: utf8.encode(jsonEncode({
              'idWorker': idWorker,
              'idBusiness': idBusiness,
            })));

    if (response.statusCode == 200) return 'Todo ok';
    throw Exception('Failed to add item');
  }

  static Future<String> verifyCita(
      String statusActual, String status, String idCita, WidgetRef ref) async {
    if (statusActual == "Aprobada") return "ok";
    final response = await http.put(Uri.parse('$serverUrl/api/cita/verifyCita'),
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(jsonEncode({
          'idCita': idCita,
          'status': status,
        })));

    if (response.statusCode == 200) {
      final List<dynamic> citas = jsonDecode(response.body);
      ref
          .read(eventsProvider.notifier)
          .cargarCitasUsuario(citas, DateTime.now());
      return 'Todo ok';
    }
    throw Exception('Failed to add item');
  }

  static Future<String> updateWorkersInBusiness(
      String businessId, String workerId) async {
    final response = await http.put(Uri.parse('$serverUrl/api/business/update'),
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(jsonEncode({
          'workerId': workerId,
          'businessId': businessId,
        })));

    if (response.statusCode == 200) return 'Todo ok';
    throw Exception('Failed to add item');
  }

  static Future<String> updateBusinessSchedule(
      String businessId, Map horario) async {
    final response = await http.put(
        Uri.parse('$serverUrl/api/business/updateBusinessSchedule'),
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(jsonEncode({
          'horario': horario,
          'idBusiness': businessId,
        })));

    if (response.statusCode == 200) return 'Todo ok';
    throw Exception('Failed to add item');
  }

  static Future<String> updateServiceInBusiness(
      String idBusiness, String idService) async {
    final response =
        await http.put(Uri.parse('$serverUrl/api/business/serviceupdate'),
            headers: {'Content-Type': 'application/json'},
            body: utf8.encode(jsonEncode({
              'idService': idService,
              'idBusiness': idBusiness,
            })));

    if (response.statusCode == 200) return 'Todo ok';
    throw Exception('Failed to add item');
  }

  static Future<String> postService(
      BuildContext context,
      String idBusiness,
      WidgetRef ref,
      String nombreServicio,
      double precio,
      String duracion,
      String descripcion,
      double time) async {
    final response =
        await http.post(Uri.parse('$serverUrl/api/services/post/service'),
            headers: {'Content-Type': 'application/json'},
            body: utf8.encode(jsonEncode({
              'idBusiness': idBusiness,
              'nombreServicio': nombreServicio,
              'precio': precio,
              'imgPath': [],
              'duracion': duracion,
              'descripcion': descripcion,
              'time': time
            })));
    if (response.statusCode == 200) {
      //await API.postImagen(imgPath, serviceData['_id'], 'worker');
      //await API.mensaje(context, 'Aviso', 'El servicio fue creado');
      ref.read(myBusinessStateProvider.notifier).setService2(response);

      return 'Todo ok';
    }
    if (response.statusCode == 202) {
      if (context.mounted) {
        API.mensaje(context, 'Aviso', 'El servicio se repite');
        return 'Todo ok';
      }
    }

    throw Exception('Failed to add item');
  }

  static Future<String> postCita(
    BuildContext context,
    WidgetRef ref,
    Map cita,
    String idUsuario,
    String idWorker,
    String idBusiness,
    String workerEmail,
  ) async {
    final response = await http.post(Uri.parse('$serverUrl/api/cita/create'),
        headers: {
          'Content-Type': 'application/json',
          'x-access-token': idUsuario
        },
        body: utf8.encode(jsonEncode({
          'cita': cita,
          'idWorker': idWorker,
          'idBusiness': idBusiness,
        })));
    if (response.statusCode == 201) {
      // emitirCita(workerEmail);
      mensaje(context, 'Cita enviada',
          'Su cita fue enviada al trabajador, le enviaremos una notificación cuando este la acepte');
      return 'Todo ok';
    }
    if (response.statusCode == 202) {
      mensaje(context, 'Horario no disponible',
          'El horario no está disponible, desea intentar hacer la cita aunque esté fuera del horario, le recordamos que lo más probable es que no acepten su cita');

      return 'Todo ok';
    }

    throw Exception('Failed to add item');
  }

  static Future<List<Worker>> getWorkers(String businessId) async {
    final response = await http.get(Uri.parse('$serverUrl/api/workers/get'),
        headers: {'businessId': businessId});
    if (response.statusCode == 200) {
      final List<dynamic> workerList1 = jsonDecode(response.body);
      //final List<dynamic> workerList = json.decode(workerList1);
      final List<Worker> trabajadores = workerList1.map((trabajador) {
        Worker negocio = Worker.fromJson(trabajador);
        return negocio;
      }).toList();
      for (var element in trabajadores) {
        // element.imgPath[0] = await API.downloadImage(element.imgPath[0]);
      }
      return trabajadores;
    }
    if (response.statusCode == 201) {
      return [];
    }
    throw Exception('Failed to get items');
  }

/*
  static Future<void> connect(BuildContext context) async {
    socket.connect();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    socket.on('negocioEliminado', (id) {
      List<String> lista = prefs.getStringList('negociosInaccesibles')!;
      lista.add(id);
      prefs.setStringList('negociosInaccesibles', lista);
      if (prefs.getString('negocioActual') == id) {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return;
      }
      log('Se borró el negocio $id');
    });
    socket.on('notificacion', (notificacion) {
      showNot(notificacion);
    });
    socket.on('solicitudEntrante', (notificacion) {
      showNot(notificacion);
    });
    socket.emit("UsuarioRegistrado", prefs.getString('emailUser'));
  }
*/
  static void llamar(int numero) {
    launchUrl(Uri.parse('tel://$numero'));
  }

/*  static Future<void> desconnect() async {
    socket.disconnect();
  }

  static Future<void> emitir(String id) async {
    socket.emit("deleteBusiness", id);
  }

  static Future<void> emitirCita(String workerEmail) async {
    socket.emit("citaEmitida", workerEmail);
  }*/

  static Future<List<Service>> getService(String idBusiness) async {
    final response = await http.get(
        Uri.parse('$serverUrl/api/services/get/all'),
        headers: {'idBusiness': idBusiness});
    if (response.statusCode == 200) {
      final List<dynamic> serviceList = jsonDecode(response.body);
      //final List<dynamic> workerList = json.decode(workerList1);
      final List<Service> servicios = serviceList.map((servicio) {
        Service servicioActual = Service.fromJson(servicio);
        return servicioActual;
      }).toList();
      return servicios;
    }
    if (response.statusCode == 201) {
      return [];
    }
    throw Exception('Failed to get items');
  }

  static reRender(WidgetRef ref) {
    ref.read(reRenderProvider.notifier).reRender();
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: (DefaultFirebaseOptions.currentPlatform ==
                    DefaultFirebaseOptions.ios)
                ? DefaultFirebaseOptions.currentPlatform.iosClientId
                : DefaultFirebaseOptions.currentPlatform.androidClientId)
        .signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static cat(String cat) {
    actualCat = cat;
  }

  static setCat(String cat) {
    categoriaABuscar = cat;
  }

  static noHay(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text('No hay negocios'),
              content: Text(
                  'No hay nadie que sea dueño de este tipo de negocio según tus preferencias de busqueda, esta puede ser una gran oportunidad para tí, ¿quieres crear tu negocio?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessRegisterPage(),
                          ));
                    },
                    child: Text('Si'))
              ],
            ));
  }

  static mensaje(BuildContext context, String titulo, String mensaje) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text(titulo),
              content: Text(mensaje),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Gracias')),
              ],
            ));
  }

  static void showDuracion(BuildContext context, Widget child) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
    //API.reRender(ref);
  }

  static mensaje2(BuildContext context, String titulo) {
    FToast fToast = FToast();

    fToast.init(context);

    showToast() {
      Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.black.withOpacity(0.7),
        ),
        child: Text(
          titulo,
          style: TextStyle(color: Colors.white),
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 1),
      );
    }

    showToast();
  }

  static cambiarHorario(
      BuildContext context, WidgetRef ref, String dia, Map turno) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text('Que desea hacer con este horario'),
              content: Text(
                  'Desea cambiar, eliminar o no hacer nada con este horario.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Nada')),
                TextButton(
                    onPressed: () async {
                      try {
                        TimeOfDay inicio =
                            await API.timePicker(context, 'Horario de inicio');
                        if (context.mounted) {
                          TimeOfDay fin =
                              await API.timePicker(context, 'Horario de fin');

                          ref
                              .read(myBusinessStateProvider.notifier)
                              .cambiarHorario(dia, turno, inicio, fin);
                          ref.read(reRenderProvider.notifier).reRender();
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      } catch (e) {
                        return;
                      }
                    },
                    child: Text('Cambiar')),
                TextButton(
                    onPressed: () {
                      ref
                          .read(myBusinessStateProvider.notifier)
                          .eliminarHorario(dia, turno);
                      ref.read(reRenderProvider.notifier).reRender();
                      Navigator.pop(context);
                    },
                    child: Text('Eliminar'))
              ],
            ));
  }

  static timePicker(BuildContext context, String titulo) {
    final selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      helpText: titulo,
      errorInvalidText: "Eso no es un tiempo válido",
      cancelText: "Cancelame esta mierda",
    );
    if (selectedTime == null) return null;

    return selectedTime;
  }

  static datePicker(BuildContext context) {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(3000),
    );

    return selectedDate;
  }

  static noHayPropios(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text('Advertencia'),
              content: Text(
                  'No eres dueño ni empleado de ningún negocio, ¿quieres crear tu negocio?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessRegisterPage(),
                          ));
                    },
                    child: Text('Si'))
              ],
            ));
  }

  static estasSeguro(BuildContext context, String businessId) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text('Advertencia'),
              content: Column(
                children: [
                  Text('Una vez borrado cagaste'),
                  Cuadro(control: TextEditingController(), texto: 'Contraseña')
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      API.deleteBusiness(businessId);
                    },
                    child: Text('Si')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'))
              ],
            ));
  }

  static String getCat() {
    return actualCat;
  }

  static Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNot(String not) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high);
    /*const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();*/
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        1, 'Prro te aviso que...', not, notificationDetails);
  }

  static var estiloJ24negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF14181B), fontSize: 24, fontWeight: FontWeight.w500);
  static var estiloJ14negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF15161E), fontSize: 14, fontWeight: FontWeight.w500);
  static var estiloJ14gris = GoogleFonts.plusJakartaSans(
      color: Color.fromRGBO(96, 106, 133, 1),
      fontSize: 14,
      fontWeight: FontWeight.w500);
  static var estiloJ16negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF14181B), fontSize: 16, fontWeight: FontWeight.normal);
}
