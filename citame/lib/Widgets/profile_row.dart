import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileRow extends ConsumerWidget {
  final String description;
  final IconData icon;
  final Widget page;
  final bool exit;
  const ProfileRow({
    Key? key,
    required this.description,
    required this.icon,
    required this.page,
    required this.exit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        if (exit) {
          try {
            String? metodo =
                FirebaseAuth.instance.currentUser?.providerData[0].providerId;
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              Navigator.pop(context);
              if (metodo == "google.com") {
                Navigator.pop(context);
              }
            }
          } catch (e) {
            print(e.toString());
          }
        }
        if (context.mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ));
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
