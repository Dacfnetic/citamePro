import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('No hay servicios de geolocalización');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Los servicios fueron denegados');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Denegados perpetuamente');
  }

  return await Geolocator.getCurrentPosition();
}

final geoProvider = StateNotifierProvider<GeoNotifier, List<double>>((ref) {
  return GeoNotifier();
});

class GeoNotifier extends StateNotifier<List<double>> {
  GeoNotifier() : super([0, 0, 0]);

  void obtener() {
    _getCurrentLocation().then((value) {
      state[0] = value.latitude;
      state[1] = value.longitude;
      state[2] = value.altitude;
    });
  }

  List<double> aCartesianas(
      {latitud = double, longitud = double, altitud = double}) {
    double x = altitud * sin(latitud * toRad) * cos(longitud * toRad);
    double y = altitud * sin(latitud * toRad) * sin(longitud * toRad);
    double z = altitud * cos(latitud * toRad);
    return [x, y, z];
  }

  List<double> aEsfericas({x = double, y = double, z = double}) {
    double altitud = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
    double latitud = acos(z / altitud);
    double longitud = atan(y / x);

    return [latitud, longitud, altitud];
  }

  double distanciaEnMillas({
    latitudA = double,
    longitudA = double,
    latitudB = double,
    longitudB = double,
  }) {
    double diferencia = longitudA - longitudB;
    if (diferencia < 0) diferencia *= -1;
    double distancia = (sin(latitudA * toRad) * sin(latitudB * toRad)) +
        (cos(latitudA * toRad) *
            cos(latitudB * toRad) *
            cos(diferencia * toRad));
    return acos(distancia) * toDeg * 60;
  }

  double distanciaEnKilometros({
    latitudA = double,
    longitudA = double,
    latitudB = double,
    longitudB = double,
  }) {
    double diferencia = longitudA - longitudB;
    if (diferencia < 0) diferencia *= -1;
    double distancia =
        cos((90 - latitudA) * toRad) * cos((90 - latitudB) * toRad) +
            sin((90 - latitudA) * toRad) *
                sin((90 - latitudB) * toRad) *
                cos(diferencia * toRad);
    return acos(distancia) * 60 * 1.609;
  }
}

const pi = 3.1416;

const toDeg = 360 / (2 * pi);

const toRad = 2 * pi / 360;
