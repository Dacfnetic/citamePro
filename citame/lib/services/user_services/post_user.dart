import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:citame/pages/Home/home_page.dart';
import 'package:citame/services/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostUser {
  static Future<void> postUser(BuildContext context, String googleId,
      String? userName, String? emailUser, String? avatar) async {
    // #region Declaración de funciones
    Future<String> getToken() async {
      // Obtiene el token especifico del dispositivo solicitandolo a google
      String deviceToken = "";
      await FirebaseMessaging.instance.getToken().then((token) {
        deviceToken = token!;
        return token;
      }).catchError((e) {
        log(e.toString());
        return 'No hay token';
      });
      return deviceToken;
    }

    void requestPermission() async {
      // Solicita permisos de geolocalización, notificaciones, entre otros.
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log("User granted permission");
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log("User granted provisional permission");
      } else {
        log("User declined or has not accepted permission");
      }
    }

    // #endregion
    // #region Inicializar valores
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('googleId') == null ||
        prefs.getString('googleId') != googleId) {
      prefs.setString('googleId', googleId);
      prefs.setString('userName', userName!);
      prefs.setString('negocioActual', '');
      prefs.setString('emailUser', emailUser!);
      prefs.setString('avatar', avatar!);
      prefs.setStringList('negociosInaccesibles', []);
      prefs.setString('deviceToken', await getToken());
      requestPermission();
    }
    // #endregion
    // #region Enviar solicitud al server
    final response = await http.post(Uri.parse('${API.server}/api/user/create'),
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(jsonEncode({
          'googleId': googleId,
          'userName': userName,
          'emailUser': emailUser,
          'avatar': avatar,
          'deviceToken': prefs.getString('deviceToken'),
        })));

    // #endregion
    // #region Recibir solicitud del server
    if (response.statusCode == 201 || response.statusCode == 200) {
      final contenido = jsonDecode(response.body);
      prefs.setString('llaveDeUsuario', contenido['token']);
      prefs.setString('datos', contenido['usuario']);
      if (context.mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      }
    } else {
      throw Exception('Failed to add item');
    }
    // #endregion
  }
}
