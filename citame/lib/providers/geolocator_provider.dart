import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

Position hola = Position(
  longitude: 0,
  latitude: 0,
  timestamp: DateTime.now(),
  accuracy: 0,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

final geoProvider = StateNotifierProvider<GeoNotifier, Position>((ref) {
  return GeoNotifier();
});

class GeoNotifier extends StateNotifier<Position> {
  GeoNotifier() : super(hola);

  void obtener() {
    Position position =
        Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
            as Position;
    state = position;
  }
}
