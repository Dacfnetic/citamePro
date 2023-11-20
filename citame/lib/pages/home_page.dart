import 'dart:convert';

import 'package:citame/Widgets/home_row.dart';
import 'package:citame/models/user_model.dart';
import 'package:citame/pages/pages_1/profile_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/categories_provider.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/providers/navbar_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends ConsumerWidget {
  HomePage({
    super.key,
  });
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String serverUrl = 'http://192.168.0.6:4000';
    FirebaseAuth auth = FirebaseAuth.instance;

    Future<Usuario> getProfilePhoto() async {
      final response = await http.get(Uri.parse('$serverUrl/api/user'),
          headers: {'googleId': auth.currentUser!.uid});
      if (response.statusCode == 200) {
        final List<dynamic> usuarios = jsonDecode(response.body);
        final Usuario usuario = Usuario(
            googleId: usuarios[0]['googleId'],
            userName: usuarios[0]['UserName'],
            userEmail: usuarios[0]['EmailUser'],
            avatar: usuarios[0]['avatar']);
        return usuario;
      } else {
        print(response);
        throw Exception('Failed to get items');
      }
    }

    List<HomeRow> categorias = ref.watch(categoriesProvider);
    ref.watch(geoProvider.notifier).obtener();

    CategoristListNotifier categoriesController =
        ref.read(categoriesProvider.notifier);

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
                                  categoriesController.filtrar(value),
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
                  'Categorias',
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
                    children: categorias,
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
          onDestinationSelected: (value) async {
            Usuario currentUser = await getProfilePhoto();
            ref.read(navbarProvider.notifier).changeState(value);
            if (value == 2) {
              if (context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: currentUser),
                    ));
              }
              ref.read(businessProvider.notifier).inicializar();
              ref.read(categoriesProvider.notifier).inicializar();
              searchBarController.text = "";
            }
            if (value == 1) {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatsPage(),
                  ));*/
              ref.read(businessProvider.notifier).inicializar();
              ref.read(categoriesProvider.notifier).inicializar();
              searchBarController.text = "";
            }
          },
          elevation: 0,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
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
