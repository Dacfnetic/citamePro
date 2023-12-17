import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:citame/services/chat_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/pages/signin_page.dart';
import 'package:citame/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callback);
  Workmanager().registerOneOffTask("uniqueName", "taskName");
  await initNotification();
  //String ruta = 'ws://https://ws.citame.store';
  //final socket = await Socket.connect(API.server, 4000);
  //print(socket);
  /*final channel = WebSocketChannel.connect(
    Uri.parse(ruta),
  );*/
  // print(channel);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Dart client
  IO.Socket socket = IO.io('http://localhost:3000');
  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });
  socket.on('event', (data) => print(data));
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));

  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ChatService chatService = ChatService();

    return MaterialApp(
      builder: FToastBuilder(),
      title: 'Citame',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
            displayLarge: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: const TextStyle(
              fontSize: 16,
            ),
            bodyMedium: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            )),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot);
            print(snapshot.data);
            print(snapshot.data!.uid);

            API.postUser(snapshot.data!.uid, snapshot.data!.displayName,
                snapshot.data!.email, snapshot.data!.photoURL);
            return HomePage();
            /*return StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot2) {
                print(snapshot2);
                return HomePage();
              },
            );*/
          }

          return const SignInPage();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

void callback() {
  Workmanager().executeTask((taskName, inputData) {
    showNot();
    return Future.value(true);
  });
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> showNot() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max, priority: Priority.high);
  const DarwinNotificationDetails darwinNotificationDetails =
      DarwinNotificationDetails();
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(1, 'Prro te aviso que...',
      'Alguien te agregó a un negocio como trabajador', notificationDetails);
}
