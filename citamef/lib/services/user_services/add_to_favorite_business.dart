import 'dart:convert';
import 'dart:io';
import 'package:citame/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class AddToFavoriteBusiness {
  static void addToFavoritesBusiness(String idBusiness) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await http.put(Uri.parse('$serverUrl/api/user/favoriteBusiness'),
            headers: {
              'Content-Type': 'application/json',
              HttpHeaders.authorizationHeader:
                  prefs.getString('llaveDeUsuario')!,
            },
            body: utf8.encode(jsonEncode({
              'idBusiness': idBusiness,
            })));

    if (response.statusCode == 200) prefs.setString('data', response.body);
  }
}
