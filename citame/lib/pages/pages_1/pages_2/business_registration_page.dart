import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/Widgets/photo_container.dart';
import 'package:citame/Widgets/photo_with_text.dart';
import 'package:citame/pages/pages_1/pages_2/map_page.dart';
import 'package:citame/providers/marker_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusinessRegisterPage extends ConsumerWidget {
  BusinessRegisterPage({
    super.key,
  });
  final TextEditingController description = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController physicalDirection = TextEditingController();
  final TextEditingController geographicalDirection = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController cel = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = FirebaseAuth.instance;

    Marker negocio = ref.watch(markerProvider);
    const String mensaje =
        'Facilidad de uso: Nuestra aplicación es intuitiva y fácil de usar.\n\nAcceso rápido: Con nuestra aplicación, puedes programar citas desde cualquier lugar y en cualquier momento, gracias a su accesibilidad en dispositivos móviles.\n\nRecordatorios automáticos: Olvídate de preocuparte por olvidar tus citas. Nuestra aplicación te notifica';
    final indicaciones = GoogleFonts.plusJakartaSans(
      color: Color(0xff57636c),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    final titulos = GoogleFonts.plusJakartaSans(
      color: Color(0xff57636c),
      fontSize: 36,
      fontWeight: FontWeight.w500,
    );
    final letraBlanca = GoogleFonts.plusJakartaSans(
      color: Color(0xffffffff),
      fontSize: 36,
      fontWeight: FontWeight.w600,
    );
    final letraBlancaSmall = GoogleFonts.plusJakartaSans(
      color: Color(0xffffffff),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      body: Form(
        key: signUpKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              FotoConTexto(mensaje: 'No recuerdo', estilo: letraBlanca),
              SizedBox(height: 12),
              FotoConTexto(mensaje: mensaje, estilo: letraBlancaSmall),
              Text('Datos del negocio', style: titulos),
              Text('Foto del negocio (obligatorio)', style: indicaciones),
              EspacioParaSubirFotoDeNegocio(),
              Text('Llene los siguientes campos', style: indicaciones),
              SizedBox(height: 12),
              Cuadro(control: businessName, texto: 'Nombre del negocio'),
              SizedBox(height: 12),
              Cuadro(control: category, texto: 'Categoría del negocio'),
              SizedBox(height: 12),
              Cuadro(control: email, texto: 'Correo (opcional)'),
              SizedBox(height: 12),
              Cuadro(control: cel, texto: 'Número de contacto'),
              SizedBox(height: 12),
              Cuadro(control: physicalDirection, texto: 'Dirección'),
              SizedBox(height: 12),
              //El siguiente botón abre el google maps para ubicar el negocio
              ElevatedButton(
                onPressed: () async {
                  try {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(),
                        ));
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: TextFormField(
                  controller: geographicalDirection,
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    label: Text(
                        'Dirección geográfica ${negocio.position.latitude}, ${negocio.position.longitude}'),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Cuadro(control: description, texto: 'Descripción'),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () async {
                  try {
                    if (signUpKey.currentState!.validate()) {
                      //var resultado = '';
                      await API.postBusiness(
                        //TODO: Agregar imagen del negocio e identificador de usuario
                        businessName.text,
                        category.text,
                        auth.currentUser!.email,
                        //auth.currentUser!.uid,
                        [],
                        cel.text,
                        physicalDirection.text,
                        negocio.position.latitude.toString(),
                        negocio.position.longitude.toString(),
                        description.text,
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text('Registrar negocio'),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
