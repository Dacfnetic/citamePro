import 'dart:async';
import 'dart:convert';
import 'package:citame/models/business_model.dart';
import 'package:citame/models/user_model.dart';
import 'package:citame/providers/event_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
abstract class userAPI {
  //este es put
  static Future<String> addToFavoritesBusiness(String idBusiness) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool isAuth = await API.verifyTokenUser();
    final response =
        await http.put(Uri.parse('$serverUrl/api/user/favoriteBusiness'),
            headers: {
              'Content-Type': 'application/json',
              'x-access-token': prefs.getString('llaveDeUsuario')!
            },
            body: utf8.encode(jsonEncode({
              'idBusiness': idBusiness,
            })));

    if (response.statusCode == 200) return 'Todo ok';
    throw Exception('Failed to add item');
  }

//estos son post
  static Future<void> postUser(String googleId, String? userName,
      String? emailUser, String? avatar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('negociosInaccesibles') == null) {
      prefs.setStringList('negociosInaccesibles', []);
    }
    if (prefs.getString('negocioActual') == null) {
      prefs.setString('negocioActual', '');
    }
    if (prefs.getString('googleId') == null ||
        prefs.getString('googleId') != googleId) {
      prefs.setString('googleId', googleId);
    }
    if (prefs.getString('userName') == null ||
        prefs.getString('userName') != userName) {
      prefs.setString('userName', userName!);
    }
    if (prefs.getString('emailUser') == null ||
        prefs.getString('emailUser') != emailUser) {
      prefs.setString('emailUser', emailUser!);
    }
    if (prefs.getString('avatar') == null ||
        prefs.getString('avatar') != avatar) {
      prefs.setString('avatar', avatar!);
    }

    final response = await http.post(Uri.parse('${API.server}/api/user/create'),
        headers: {'Content-Type': 'application/json'},
        body: utf8.encode(jsonEncode({
          'googleId': googleId,
          'userName': userName,
          'emailUser': emailUser,
          'avatar': avatar,
        })));
    if (response.statusCode == 201 || response.statusCode == 202) {
      final contenido = jsonDecode(response.body);
      prefs.setString('llaveDeUsuario', contenido['token']);
    }

    throw Exception('Failed to add item');
  }

  //estos son gets
  static Future<List<Business>> getOwnerBusiness(
      BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await API.verifyOwnerBusiness();
    var estado = prefs.getString('ownerBusinessStatus');
    var email = prefs.getString('emailUser');
    final response = await http.get(
        Uri.parse('$serverUrl/api/business/get/owner'),
        headers: {'email': email!, 'estado': estado!});

    if (response.statusCode == 201) {
      final List<dynamic> businessList = jsonDecode(response.body);
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();

      List<String> aGuardar = businesses.map((e) => jsonEncode(e)).toList();
      prefs.setStringList('negocios', aGuardar);

      ref.read(myBusinessStateProvider.notifier).cargar(businesses);
      if (context.mounted) {
        if (businesses.isEmpty) {
          API.noHayPropios(context);
        }
      }
      final List<String> nombres =
          businesses.map((neg) => neg.businessName).toList();
      prefs.setStringList('ownerBusiness', nombres);

      return businesses;
    }

    if (response.statusCode == 200) {
      List<Business> negocios = prefs
          .getStringList('negocios')!
          .map((e) => Business.fromJson2(jsonDecode(e)))
          .toList();
      print(negocios);
      if (context.mounted) {
        if (prefs.getStringList('ownerBusiness')!.isEmpty) {
          API.noHayPropios(context);
        }
      }
      return negocios;
    }
    throw Exception('Failed to get items');
  }

  static Future<List<Business>> getFavBusiness(
      BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http
        .get(Uri.parse('$serverUrl/api/business/FavBusiness'), headers: {
      'Content-Type': 'application/json',
      'x-access-token': prefs.getString('llaveDeUsuario')!
    });

    if (response.statusCode == 200) {
      final List<dynamic> businessList = jsonDecode(response.body);
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();

      ref.read(myBusinessStateProvider.notifier).cargar(businesses);

      if (context.mounted) {
        if (businesses.isEmpty) {
          API.noHayPropios(context);
        }
      }

      return businesses;
    }

    throw Exception('Failed to get items');
  }

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

  static Future<List<String>> getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$serverUrl/api/user/get/all'),
        headers: {'googleId': prefs.getString('googleId')!});
    if (response.statusCode == 200) {
      final List<dynamic> userList = jsonDecode(response.body);
      final List<Usuario> usuarios = userList.map((user) {
        Usuario u = Usuario.fromJson(user);
        return u;
      }).toList();
      final List<String> nombres = usuarios.map((e) => e.userName).toList();
      return nombres;
    }
    throw Exception('Failed to get items');
  }
}
