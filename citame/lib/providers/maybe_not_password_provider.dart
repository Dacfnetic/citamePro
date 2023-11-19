import 'package:flutter_riverpod/flutter_riverpod.dart';

final passProvider = StateNotifierProvider<PassNotifier, bool>((ref) {
  return PassNotifier();
});

class PassNotifier extends StateNotifier<bool> {
  PassNotifier() : super(true);

  void changeState() {
    state = !state;
  }
}

final passProvider2 = StateNotifierProvider<PassNotifier2, bool>((ref) {
  return PassNotifier2();
});

class PassNotifier2 extends StateNotifier<bool> {
  PassNotifier2() : super(true);

  void changeState() {
    state = !state;
  }
}
