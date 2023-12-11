import 'dart:typed_data';

import 'package:citame/pages/pages_1/pages_2/business_inside_page.dart';
import 'package:citame/pages/pages_1/pages_2/my_businessess_page.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/preview_business_page.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/providers/my_actual_business_provider.dart';
import 'package:citame/providers/page_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessCard extends ConsumerWidget {
  final String nombre;
  final String categoria;
  final String description;
  final double latitud;
  final double longitud;
  final double rating;
  final List<int> imagen;
  final String googleId;
  const BusinessCard({
    Key? key,
    required this.nombre,
    required this.categoria,
    required this.latitud,
    required this.longitud,
    required this.rating,
    required this.imagen,
    required this.description,
    required this.googleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<double> coordenadas = ref.watch(geoProvider);
    double distancia = ref.read(geoProvider.notifier).distanciaEnMillas(
        latitudA: latitud,
        longitudA: longitud,
        latitudB: coordenadas[0],
        longitudB: coordenadas[1]);

    Uint8List esta = Uint8List.fromList(imagen);
    return Container(
      height: 333,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue,
      ),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.red),
        ),
        onPressed: () {
          Widget actual = ref.read(pageProvider);
          ref.read(actualBusinessProvider.notifier).actualizar(nombre);
          if (actual.runtimeType == MyBusinessesPage().runtimeType) {
            API.getWorkers(googleId, nombre);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewBusinessPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessInsidePage(
                  businessName: nombre,
                  imagen: esta,
                  description: description,
                ),
              ),
            );
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.memory(
                esta,
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nombre,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFF15161E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${distancia.toStringAsFixed(2)} miles away',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF606A85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${(distancia * 1.609).toStringAsFixed(2)} kilometers away',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF606A85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  rating.toStringAsFixed(2),
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFF606A85),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.star_rounded,
                  color: Color(0xFF606A85),
                  size: 24,
                ),
              ],
            ),
            SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
