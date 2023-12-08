import 'package:citame/models/user_model.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actualBusinessProvider =
    StateNotifierProvider<MyActualBusiness, String>((ref) {
  return MyActualBusiness();
});

class MyActualBusiness extends StateNotifier<String> {
  MyActualBusiness() : super('');

  void actualizar(page) {
    state = page;
  }
}
