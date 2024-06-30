import 'dart:async';
import 'dart:io';
import 'package:citame/services/api_service.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
abstract class PostBusiness {
  static Future<String> postBusiness(
    String businessName,
    String category,
    String email,
    String contactNumber,
    String direction,
    String latitude,
    String longitude,
    String description,
    File imgPath,
    String destiny,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/business/create'));
    // #region Enviar solicitud al server
    request.files
        .add(await http.MultipartFile.fromPath('imagen', imgPath.path));
    request.fields['businessName'] = businessName;
    request.fields['category'] = category;
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
    if (response.statusCode == 201) return 'Bien';
    if (response.statusCode == 202) return "El negocio ya existe";
    throw Exception('Failed to add item');
    // #endregion
  }
}
