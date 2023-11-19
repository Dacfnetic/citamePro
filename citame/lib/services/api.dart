import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:status_alert/status_alert.dart';

class Api {
  static const baseUrl = "https://192.168.0.6:4000";

  //get method
  static postUser(BuildContext context, String path, String googleId,
      String? userName, String? emailUser, String? avatar) async {
    var url = Uri.parse('$baseUrl$path');

    var user = {
      'googleId': googleId,
      'UserName': userName,
      'EmailUser': emailUser,
      'avatar': avatar,
    };

    final res = await http.post(url, body: user);

    try {
      if (res.statusCode == 200) {
        var mensaje = res.body;
        print(mensaje);
        if (context.mounted) {
          StatusAlert.show(
            context,
            duration: const Duration(seconds: 4),
            title: 'Todo bien',
            subtitle: mensaje,
            configuration:
                const IconConfiguration(icon: Icons.close, color: Colors.red),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        StatusAlert.show(
          context,
          duration: const Duration(seconds: 4),
          title: 'Error en algo',
          subtitle: e.toString(),
          configuration:
              const IconConfiguration(icon: Icons.close, color: Colors.red),
        );
      }
    }
  }

  static getAdvice(BuildContext context, String path) async {
    var url = Uri.parse('$baseUrl$path');
    final res = await http.get(url);

    try {
      if (res.statusCode == 200) {
        var mensaje = res.body;
        print(mensaje);
        if (context.mounted) {
          StatusAlert.show(
            context,
            duration: const Duration(seconds: 4),
            title: 'Todo bien',
            subtitle: mensaje,
            configuration:
                const IconConfiguration(icon: Icons.close, color: Colors.red),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        StatusAlert.show(
          context,
          duration: const Duration(seconds: 4),
          title: 'Error en algo',
          subtitle: e.toString(),
          configuration:
              const IconConfiguration(icon: Icons.close, color: Colors.red),
        );
      }
    }
  }
}
