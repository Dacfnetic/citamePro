import 'dart:async';
import 'dart:io';
import 'package:citame/services/api_service.dart';
import 'package:http/http.dart' as http;

// ignore: library_prefixes
abstract class PostImage {
  static Future<String> postImage(
      File imagen, String id, String destiny) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/imagen/upload'));

    request.files.add(await http.MultipartFile.fromPath('imagen', imagen.path));
    request.fields['id'] = id;
    request.fields['destiny'] = destiny;

    var response = await request.send();

    if (response.statusCode == 201) return 'Todo ok';
    if (response.statusCode == 202) return 'Todo ok';

    throw Exception('Failed to adddsds item');
  }
}
