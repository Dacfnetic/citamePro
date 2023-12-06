import 'package:citame/Widgets/business_card.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/pages/pages_1/pages_2/business_registration_page.dart';
import 'package:citame/pages/pages_1/pages_2/my_businessess_page.dart';
import 'package:citame/providers/own_business_provider.dart';
import 'package:citame/services/api_service.dart';
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
    Key? key,
    required this.description,
    required this.icon,
    required this.page,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (method == 0) {
          try {
            /*String? metodo =
                FirebaseAuth.instance.currentUser?.providerData[0].providerId;*/

            await prefs.clear();
            ref.read(ownBusinessProvider.notifier).limpiar();
            await GoogleSignIn().disconnect();
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          } catch (e) {
            print(e.toString());
          }
        }
        if (method == 1) {
          //try {

          if (context.mounted) {
            if (prefs.getStringList('ownerBusiness') == null) {
              prefs.setStringList('ownerBusiness', []);
            }
            if (prefs.getStringList('ownerBusiness')!.length != 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBusinessesPage(),
                  ));
              ref.read(ownBusinessProvider.notifier).cargar();
            } else {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        elevation: 24,
                        title: Text('Advertencia'),
                        content: Text(
                            'No eres dueño ni empleado de ningún negocio, ¿quieres crear tu negocio?'),
                        actions: [
                          TextButton(onPressed: () {}, child: Text('No')),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BusinessRegisterPage(),
                                    ));
                              },
                              child: Text('Si'))
                        ],
                      ));
            }
          }

          //}
          //} catch (e) {
          //  print(e.toString());
          //}
        }
        if (method == 2) {
          if (context.mounted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ));
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
