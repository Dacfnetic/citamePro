import 'dart:async';
import 'dart:convert';
import 'package:citame/models/business_model.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetBusiness {
  static Future<List<Business>> getBusiness(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('emailUser');

    final response = await http.get(
      Uri.parse('$serverUrl/api/business/get/all'),
      headers: {
        'email': email!,
        'category': categoriaABuscar,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> businessList = jsonDecode(response
          .body); //Guardar lo que recibo del back en una lista de objetos
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();
      if (context.mounted) {
        if (businesses.isEmpty) {
          API.noHay(context);
        }
      }

      return businesses;
    }

    throw Exception('Failed to get items');
  }
}
