import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snapProvider =
    StateNotifierProvider<ReRenderNotifier, AsyncSnapshot<dynamic>>((ref) {
  return ReRenderNotifier();
});

class ReRenderNotifier extends StateNotifier<AsyncSnapshot<dynamic>> {
  ReRenderNotifier() : super(AsyncSnapshot.nothing());

  void actualizar(entrante) {
    coso = entrante;
  }

  AsyncSnapshot<dynamic> getSnap() {
    return coso;
  }
}

AsyncSnapshot<dynamic> coso = AsyncSnapshot.nothing();
