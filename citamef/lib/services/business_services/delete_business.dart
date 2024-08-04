import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:citame/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
abstract class DeleteBusiness {
  static Future<String> deleteBusiness(String businessId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.delete(Uri.parse('$serverUrl/api/business/delete'),
            headers: {
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader:
                  prefs.getString('llaveDeUsuario')!
            },
            body: utf8.encode(jsonEncode({
              'businessId': businessId,
            })));

    if (response.statusCode == 200) {
      // emitir(businessId);
      return 'borrado';
    }

    throw Exception('Failed to add item');
  }
}
