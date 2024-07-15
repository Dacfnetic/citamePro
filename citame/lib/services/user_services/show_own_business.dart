import 'dart:async';
import 'dart:convert';
import 'package:citame/models/business_model.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ShowOwnBusiness {
  static Future<List<Business>> showOwnBusiness(
      BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<dynamic> businessList = jsonDecode(prefs.getString('datos')!);

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
}
