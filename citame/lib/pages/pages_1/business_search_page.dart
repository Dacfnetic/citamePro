import 'package:citame/Widgets/business_card.dart';
import 'package:citame/pages/pages_1/profile_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/providers/navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class BusinessSearchPage extends ConsumerWidget {
  final String categoria;

  BusinessSearchPage({
    Key? key,
    required this.categoria,
  }) : super(key: key);
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<BusinessCard> negocios = ref.watch(businessProvider);
    ref.watch(geoProvider.notifier).obtener();

    BusinessListNotifier businessController =
        ref.read(businessProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ref.read(geoProvider)[0].toString()),
                Text(ref.read(geoProvider)[1].toString()),
                Container(
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
                                  businessController.filtrar(value),
                                  /* ref
                                      .read(searchBarProvider.notifier)
                                      .actualizar(value),*/
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
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  categoria,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFF14181B),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView(
                    children: negocios,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          indicatorColor: Colors.white,
          selectedIndex: 0,
          onDestinationSelected: (value) {
            ref.read(navbarProvider.notifier).changeState(value);
            if (value == 2) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
            }
            if (value == 0) {
              Navigator.pop(context);
            }
          },
          elevation: 0,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_outlined),
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.sticky_note_2),
              icon: Icon(Icons.sticky_note_2_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2),
              icon: Icon(Icons.person_2_outlined),
              label: '',
            ),
          ]),
    );
  }
}
