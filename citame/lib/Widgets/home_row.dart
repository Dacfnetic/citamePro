import 'package:citame/pages/business_search_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/categories_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeRow extends ConsumerWidget {
  final String categoria;
  final String imagen;

  const HomeRow({
    Key? key,
    required this.categoria,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //List<HomeRow> categorias = ref.watch(categoriesProvider);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          ref.read(businessProvider.notifier).inicializar();
          ref.read(categoriesProvider.notifier).inicializar();

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessSearchPage(categoria: categoria),
              ));
        },
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imagen,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  categoria,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFF14181B),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
