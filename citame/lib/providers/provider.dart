import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, bool>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier() : super(false);

  void changeState() {
    state = !state;
  }
}
