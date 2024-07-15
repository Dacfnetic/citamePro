import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EstoyLogueado {
  static Future<bool> estoyLogueado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') == null) {
      return false;
    }
    return true;
  }
}
