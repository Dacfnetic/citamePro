import 'package:flutter_riverpod/flutter_riverpod.dart';

final navbarProvider = StateNotifierProvider<NavbarNotifier, int>((ref) {
  return NavbarNotifier();
});

class NavbarNotifier extends StateNotifier<int> {
  NavbarNotifier() : super(0);

  void changeState(index) {
    state = index;
  }
}
