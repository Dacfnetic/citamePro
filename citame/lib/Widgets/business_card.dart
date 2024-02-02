// ignore_for_file: use_build_context_synchronously

import 'package:citame/pages/pages_1/pages_2/business_inside_page.dart';
import 'package:citame/pages/pages_1/pages_2/my_businessess_page.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/menu_page.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/preview_business_page.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/providers/my_actual_business_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/page_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessCard extends ConsumerWidget {
  final String nombre;
  final String id;
  final String categoria;
  final String description;
  final double latitud;
  final double longitud;
  final double rating;
  final Map horario;
  final Uint8List imagen;
  final String email;
  final bool isDueno;
  const BusinessCard(
      {Key? key,
      required this.nombre,
      required this.id,
      required this.categoria,
      required this.latitud,
      required this.longitud,
      required this.rating,
      required this.imagen,
      required this.description,
      required this.email,
      required this.isDueno,
      required this.horario})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _settingAccess() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('negocioActual', id);
      //Este if comprueba si el negocio no está en la lista negra de negocios no accesibles
      if (!prefs.getStringList('negociosInaccesibles')!.contains(id)) {
        //Pide al back los trabajadores del negocio
        ref.read(myBusinessStateProvider.notifier).establecerWorkers(id, ref);
        //Pide al back los servicios del negocio
        ref.read(myBusinessStateProvider.notifier).setService(id, ref);
        //Almacena el id del negocio actual
        ref.read(myBusinessStateProvider.notifier).setActualBusiness(id);
        //Convierte los datos crudos del horario y los formatea para que se miren bien en el front
        ref
            .watch(myBusinessStateProvider.notifier)
            .establecerDiasGeneral(horario);
        //Envia a la página del usuario
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(),
          ),
        );
      }
    }

    List<double> coordenadas = ref.watch(geoProvider);
    double distancia = ref.read(geoProvider.notifier).distanciaEnMillas(
        latitudA: latitud,
        longitudA: longitud,
        latitudB: coordenadas[0],
        longitudB: coordenadas[1]);
    if (isDueno) {
      return Container(
        margin: EdgeInsets.all(5),
        height: 350,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          //border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Color de la sombra
              spreadRadius: 2, // Extensión de la sombra
              blurRadius: 2, // Desenfoque de la sombra
              offset: Offset(0, 1), // Desplazamiento de la sombra
            ),
          ],
          shape: BoxShape.rectangle,
          //color: Colors.blue,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    if (context.mounted) {
                      API.estasSeguro(context, id);
                    }
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
                IconButton(
                    onPressed: () => _settingAccess(),
                    icon: Icon(Icons.settings))
              ],
            ),
            Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.memory(
                      imagen,
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Text(
                              nombre,
                              style: GoogleFonts.plusJakartaSans(
                                color: Color(0xFF15161E),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${(distancia * 1.609).toStringAsFixed(2)} kilometers away',
                              style: GoogleFonts.plusJakartaSans(
                                color: Color(0xFF606A85),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          rating.toStringAsFixed(2),
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xFF606A85),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ]),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 80,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          //border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Color de la sombra
              spreadRadius: 2, // Extensión de la sombra
              blurRadius: 2, // Desenfoque de la sombra
              offset: Offset(0, 1), // Desplazamiento de la sombra
            ),
          ],
          shape: BoxShape.rectangle,
          //color: Colors.blue,
        ),
        child: TextButton(
          style: ButtonStyle(
              //backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('negocioActual', id);
            if (!prefs.getStringList('negociosInaccesibles')!.contains(id)) {
              Widget actual = ref.read(pageProvider);
              ref.read(actualBusinessProvider.notifier).actualizar(id);
              if (actual.runtimeType == MyBusinessesPage().runtimeType) {
                ref
                    .read(myBusinessStateProvider.notifier)
                    .establecerWorkers(id, ref);
                ref.read(myBusinessStateProvider.notifier).setService(id, ref);

                ref
                    .read(myBusinessStateProvider.notifier)
                    .setActualBusiness(id);
                ref
                    .read(myBusinessStateProvider.notifier)
                    .setActualEmail(email);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewBusinessPage(),
                  ),
                );
              } else {
                ref
                    .read(myBusinessStateProvider.notifier)
                    .establecerWorkers(id, ref);
                ref.read(myBusinessStateProvider.notifier).setService(id, ref);

                ref
                    .read(myBusinessStateProvider.notifier)
                    .setActualBusiness(id);
                ref
                    .read(myBusinessStateProvider.notifier)
                    .setActualEmail(email);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessInsidePage(
                        businessName: nombre,
                        imagen: imagen,
                        description: description,
                        negocio: this),
                  ),
                );
              }
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  imagen,
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nombre,
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF15161E),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${(distancia * 1.609).toStringAsFixed(2)} kms',
                      style: GoogleFonts.plusJakartaSans(
                        color: Color(0xFF606A85),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    rating.toStringAsFixed(2),
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF606A85),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                    size: 10,
                  ),
                ],
              ),
              /*SizedBox(
              height: 24,
            )*/
            ],
          ),
        ),
      );
    }
  }
}
