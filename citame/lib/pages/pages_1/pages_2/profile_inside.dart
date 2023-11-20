import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInsidePage extends ConsumerWidget {
  const ProfileInsidePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
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
                          //TODO: Adquirir nombre del perfil
                          'Mike Thomson',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xff14181b),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          //TODO: Adquirir horario del perfil
                          'Horario disponible 9am-7.30pm',
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
            ],
          ),
        ),
      ),
    );
  }
}
