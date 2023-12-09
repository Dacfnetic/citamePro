import 'package:citame/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageProvider = StateNotifierProvider<PageNotifier, Widget>((ref) {
  return PageNotifier();
});

class PageNotifier extends StateNotifier<Widget> {
  PageNotifier() : super(HomePage());

  void actualizar(page) {
    state = page;
  }
}
