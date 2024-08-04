import 'package:flutter_riverpod/flutter_riverpod.dart';

final duracionProvider =
    StateNotifierProvider<DurationNotifier, Duration>((ref) {
  return DurationNotifier();
});

class DurationNotifier extends StateNotifier<Duration> {
  DurationNotifier() : super(Duration());

  void change(duracion) {
    state = duracion;
  }
}
