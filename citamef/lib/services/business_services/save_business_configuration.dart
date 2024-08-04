import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/own_business_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types

abstract class SaveBusinessConfiguration {
  static Future<Map> saveBusinessConfiguration(
      BuildContext context,
      String businessId,
      Map horario,
      List<Service> servicios,
      List<Worker> trabajadores,
      WidgetRef ref) async {
    List paraEnviar = [];
    String horarioParaEnviar = jsonEncode(horario);
    for (var trabajador in trabajadores) {
      Map agregarALaLista = trabajador.toJson();
      agregarALaLista['horario'] = jsonEncode(trabajador.horario);
      agregarALaLista['imgPath'] = trabajador.imgPath[0].path;
      paraEnviar.add(jsonEncode(agregarALaLista));
    }
    String enviar = paraEnviar.toString();

    List paraEnviar2 = [];
    for (var serv in servicios) {
      Map agregarALaLista = serv.toJson();
      paraEnviar2.add(jsonEncode(agregarALaLista));
    }
    String enviar2 = paraEnviar2.toString();

    var request = http.MultipartRequest(
        'POST', Uri.parse('$serverUrl/api/business/saveChangesFromBusiness'));

    for (var trabajador in trabajadores) {
      request.files.add(await http.MultipartFile.fromPath(
          'imagen', trabajador.imgPath[0].path));
    }

    request.fields['businessId'] = businessId;
    request.fields['requestedServices'] = enviar2;
    request.fields['horario'] = horarioParaEnviar;
    request.fields['requestedWorkers'] = enviar;

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      log("Result: ${response.statusCode}");
      Map contenido = jsonDecode(response.body);
      ref
          .read(ownBusinessProvider.notifier)
          .actualizarUnNegocio(contenido, context, ref);
      log(contenido.toString());
      return contenido;
    }

    throw Exception('Failed to add item');
  }
}
