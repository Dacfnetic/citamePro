import 'package:citame/Widgets/profile_row.dart';
import 'package:citame/pages/pages_1/pages_2/business_registration_page.dart';
import 'package:citame/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xff14181b),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(240, 240, 240, 1),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                  )
                ]),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Color(0x4d39d2c0),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff39d2c0),
                            width: 2,
                          )

                          /*image: DecorationImage(
                          image: AssetImage('lib/assets/Splashscreen.jpg'),
                          fit: BoxFit.fill,
                        ),*/
                          ),
                      child: SizedBox(
                        height: 90,
                        width: 90,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dexter',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xff14181b),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'labdexter@gmail.com',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xff57636c),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'Perfil',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xff57636c),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ProfileRow(
                description: 'Favoritos',
                icon: Icons.favorite,
                page: Placeholder(),
                exit: false,
              ),
              ProfileRow(
                description: 'Información personal',
                icon: Icons.person,
                page: Placeholder(),
                exit: false,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'Beneficios',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xff57636c),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ProfileRow(
                description: 'Pagos',
                icon: Icons.payment,
                page: Placeholder(),
                exit: false,
              ),
              ProfileRow(
                description: 'Donaciones',
                icon: Icons.handshake,
                page: Placeholder(),
                exit: false,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'Actividad',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xff57636c),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ProfileRow(
                description: 'Invitar amigos',
                icon: Icons.card_giftcard,
                page: Placeholder(),
                exit: false,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'Configuración',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xff57636c),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              ProfileRow(
                description: 'Notificaciones',
                icon: Icons.notifications,
                page: Placeholder(),
                exit: false,
              ),
              ProfileRow(
                description: 'Registrar mi negocio',
                icon: Icons.store,
                page: BusinessRegisterPage(),
                exit: false,
              ),
              ProfileRow(
                description: 'Cerrar sesión en otros dispositivos',
                icon: Icons.logout,
                page: SignInPage(),
                exit: true,
              ),
              ProfileRow(
                description: 'Cerrar sesión',
                icon: Icons.logout,
                page: SignInPage(),
                exit: true,
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
