import 'dart:io';
import 'package:citame/Widgets/universal_variables.dart';
import 'package:citame/pages/Perfil/Negocios%20favoritos/favorites_business_page.dart';
import 'package:citame/pages/Perfil/Negocios%20propios/my_businessess_page.dart';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/my_favorites_provider.dart';
import 'package:citame/providers/own_business_provider.dart';
import 'package:citame/providers/page_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRow extends ConsumerWidget {
  final String description;
  final IconData icon;
  final Widget page;
  final int method;
  const ProfileRow({
    super.key,
    required this.description,
    required this.icon,
    required this.page,
    required this.method,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //Cerrar sesión
        if (method == 0) {
          try {
            await prefs.clear().then((value) {
              ref.read(ownBusinessProvider.notifier).limpiar();
              ref.read(myBusinessStateProvider.notifier).limpiar();
              FirebaseAuth.instance.signOut().then((value) {
                if (context.mounted) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
                GoogleSignIn().disconnect().then((value) {
                  if (context.mounted) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                });
              }, onError: (e) {
                print(e);
              });
            });
          } catch (e) {
            print(e.toString());
          }
        }

        //Mis negocios
        if (method == 1) {
          //try {
          ref.read(pageProvider.notifier).actualizar(MyBusinessesPage());
          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBusinessesPage(),
                ));
            ref
                .read(ownBusinessProvider.notifier)
                .cargar(context, ref, 'ownerBusiness');
          }
        }

        //Registrar nuevo negocio
        if (method == 2) {
          GlobalVariables.categoriaActual = GlobalVariables.categorias[0];
          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                )).then((_) {
              ref.read(imgProvider.notifier).changeState(File(''));
            });
          }
        }

        //Mis favoritos
        if (method == 3) {
          ref.read(pageProvider.notifier).actualizar(MyFavoritesPage());

          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFavoritesPage(),
                ));

            ref
                .read(myFavoritesProvider.notifier)
                .cargar(context, ref, 'favoriteBusiness');
          }
        }
      },
      child: Container(
        height: 35,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            Expanded(
              child: Text(
                '    $description',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
