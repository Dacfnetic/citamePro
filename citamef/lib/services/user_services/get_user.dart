import 'dart:async';
import 'dart:convert';
import 'package:citame/providers/event_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
abstract class GetUser {
  static Future<String> getUser(WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.get(Uri.parse('$serverUrl/api/user/get'), headers: {
      'googleId': prefs.getString('googleId')!,
      'x-access-token': prefs.getString('llaveDeUsuario')!
    });

    if (response.statusCode == 200) {
      final List<dynamic> citas = jsonDecode(response.body);
      ref
          .read(eventsProvider.notifier)
          .cargarCitasUsuario(citas, DateTime.now());
      return 'Todo ok';
    }
    throw Exception('Failed to get items');
  }
}
