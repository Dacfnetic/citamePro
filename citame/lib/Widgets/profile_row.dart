import 'dart:convert';
import 'package:citame/Widgets/business_card.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/pages/pages_1/pages_2/my_businessess_page.dart';
import 'package:citame/providers/ip_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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
    String serverUrl = ref.read(ipProvider);
    Future<List<Business>> getMyBusinesses() async {
      final response =
          await http.get(Uri.parse('$serverUrl/api/user_businesses'));
      if (response.statusCode == 200) {
        final List<dynamic> businessList = jsonDecode(response.body);
        final List<Business> businesses = businessList.map((business) {
          Business negocio = Business.fromJson(business);
          return negocio;
        }).toList();
        return businesses;
      } else {
        print(response);
        throw Exception('Failed to get items');
      }
    }

    List<Business> userBusiness;
    List<BusinessCard> negocios;
    return TextButton(
      onPressed: () async {
        if (method == 0) {
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
        if (method == 1) {
          try {
            //TODO: Implementar para crear cartas de negocios
            userBusiness = await getMyBusinesses();
            negocios = userBusiness.map((e) {
              return (BusinessCard(
                nombre: e.businessName,
                categoria: e.category,
                latitud: double.parse(e.latitude),
                longitud: double.parse(e.longitude),
                rating: 5.0,
                imagen: 'https://source.unsplash.com/random/1280x720?beach&9',
              ));
            }).toList();
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyBusinessesPage(
                      negocios: negocios,
                    ),
                  ));
            }
          } catch (e) {
            print(e.toString());
          }
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
