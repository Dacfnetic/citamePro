import 'package:citame/providers/business_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarCitame extends StatelessWidget {
  const SearchBarCitame({
    super.key,
    required this.businessFunctions,
    required this.searchBarController,
  });

  final BusinessListNotifier businessFunctions;
  final TextEditingController searchBarController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Color(0xFFE5E7EB),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.search_rounded,
              color: Color(0xFF606A85),
              size: 24,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: SizedBox(
                  child: TextField(
                    onChanged: (value) => {
                      businessFunctions.filtrar(value),
                    },
                    controller: searchBarController,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.plusJakartaSans(
                        color: Color(0xFF606A85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF15161E),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
