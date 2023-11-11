import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessCard extends StatelessWidget {
  final String nombre;
  final String categoria;
  final double distancia;
  final double rating;
  final String imagen;
  const BusinessCard({
    Key? key,
    required this.nombre,
    required this.categoria,
    required this.distancia,
    required this.rating,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
