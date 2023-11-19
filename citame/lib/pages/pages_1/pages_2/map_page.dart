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

  /*static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/

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

  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/
}
