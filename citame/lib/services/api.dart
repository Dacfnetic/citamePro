import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:status_alert/status_alert.dart';

class Api {
  static const baseUrl = "http://localhost:3000";

  //get method

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
