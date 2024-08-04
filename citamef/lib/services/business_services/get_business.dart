import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:citame/models/business_model.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetBusiness {
  static Future<List<Business>> getBusiness(BuildContext context,
      String categoria, String categoriaFavoritosOPropios) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var datos = prefs.getString('data');
    final Map data = jsonDecode(datos!);
    var favoritos = data['favoriteBusinessIds'];
    var propios = data['ownerBusinessIds'];

    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            '$serverUrl/api/business/get/all?category=$categoria&favoritos=$favoritos&propios=$propios&categoriaFavoritosOPropios=$categoriaFavoritosOPropios'));

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: prefs.getString('llaveDeUsuario')!
    };

    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      var respuesta = await http.Response.fromStream(response);
      final List<dynamic> businessList = jsonDecode(respuesta
          .body); //Guardar lo que recibo del back en una lista de objetos
      if (businessList.contains(null)) {
        if (context.mounted) {
          API.noHay(context);
        }
        return [];
      }
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();
      if (context.mounted) {
        if (businesses.isEmpty) {
          API.noHay(context);
        }
      }
      prefs.setString('datosDeNegocios', jsonEncode(businesses));
      return businesses;
    }
    if (response.statusCode == 201) {
      if (context.mounted) {
        API.noHay(context);
      }
    }

    throw Exception('Failed to get items');
  }
}
