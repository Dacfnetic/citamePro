import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final markerProvider = StateNotifierProvider<MarkerNotifier, Marker>((ref) {
  return MarkerNotifier();
});

class MarkerNotifier extends StateNotifier<Marker> {
  MarkerNotifier() : super(store);

  void changeState(index) {
    state = Marker(
        markerId: const MarkerId('store'),
        infoWindow: const InfoWindow(title: 'store'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: index);
  }
}

Marker store = Marker(
  markerId: const MarkerId('store'),
  infoWindow: const InfoWindow(title: 'store'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  position: LatLng(90, 90),
);
