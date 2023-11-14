import 'package:citame/providers/geolocator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessCard extends ConsumerWidget {
  final String nombre;
  final String categoria;
  final double latitud;
  final double longitud;

  final double rating;
  final String imagen;
  const BusinessCard({
    Key? key,
    required this.nombre,
    required this.categoria,
    required this.latitud,
    required this.longitud,
    required this.rating,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<double> coordenadas = ref.watch(geoProvider);
    String distancia = ref
        .read(geoProvider.notifier)
        .distanciaEnMillas(
            latitudA: latitud,
            longitudA: longitud,
            latitudB: coordenadas[0],
            longitudB: coordenadas[1])
        .toStringAsFixed(2);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imagen,
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
                '$distancia miles away',
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
    );
  }
}
