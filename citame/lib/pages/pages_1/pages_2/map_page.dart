import 'dart:async';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/providers/marker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends ConsumerWidget {
  MapPage({super.key});
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<double> coordenadas = ref.read(geoProvider);
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(coordenadas[0], coordenadas[1]),
      zoom: 18,
    );

    return Scaffold(
      body: GoogleMap(
        markers: {ref.watch(markerProvider)},
        onTap: (newPos) {
          ref.read(markerProvider.notifier).changeState(newPos);
        },
        mapType: MapType.hybrid,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: /*_goToTheLake*/ () {
          ref.read(businessProvider.notifier).businessLocation(store.position);
          Navigator.pop(context);
        },
        label: const Text('Aquí está mi negocio!'),
        icon: const Icon(Icons.store),
      ),
    );
  }
}
