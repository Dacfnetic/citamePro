import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:citame/Widgets/universal_variables.dart';
import 'package:citame/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
abstract class PostBusiness {
  static Future<String> postBusiness(
    String businessName,
    String email,
    String contactNumber,
    String direction,
    String latitude,
    String longitude,
    String description,
    File imgPath,
    String destiny,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/business/create'));
    // #region Enviar solicitud al server

    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: prefs.getString('llaveDeUsuario')!
    };

    request.headers.addAll(headers);

    request.files
        .add(await http.MultipartFile.fromPath('myfile', imgPath.path));
    request.fields['businessName'] = businessName;
    request.fields['category'] = GlobalVariables.categoriaActual;
    request.fields['email'] = email;
    request.fields['contactNumber'] = contactNumber;
    request.fields['direction'] = direction;
    request.fields['latitude'] = latitude;
    request.fields['longitude'] = longitude;
    request.fields['description'] = description;
    request.fields['destiny'] = destiny;
    var response = await request.send();
    // #endregion
    // #region Recibir solicitud del server
    if (response.statusCode == 201) {
      var respuesta = await http.Response.fromStream(response);
      final contenido = jsonDecode(respuesta.body);
      prefs.setString('data', jsonEncode(contenido));
      return "Ok";
    }

    if (response.statusCode == 202) return "El negocio ya existe";
    throw Exception('Failed to add item');
    // #endregion
  }
}
