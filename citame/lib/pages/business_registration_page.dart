import 'dart:ui';
import 'package:citame/pages/map_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

class BusinessRegisterPage extends ConsumerWidget {
  BusinessRegisterPage({
    super.key,
  });
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController physicalDirectionController =
      TextEditingController();
  final TextEditingController geographicalDirectionController =
      TextEditingController();
  final TextEditingController businessCategorieController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Form(
        key: signUpKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/Splashscreen.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(
                  'Crear una cuenta',
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xffffffff),
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/Splashscreen.jpg'),
                    fit: BoxFit.fill,
                    invertColors: true,
                    colorFilter: ColorFilter.srgbToLinearGamma(),
                    opacity: 0.1,
                  ),
                ),
                child: Text(
                  'Facilidad de uso: Nuestra aplicación es intuitiva y fácil de usar.\n\nAcceso rápido: Con nuestra aplicación, puedes programar citas desde cualquier lugar y en cualquier momento, gracias a su accesibilidad en dispositivos móviles.\n\nRecordatorios automáticos: Olvídate de preocuparte por olvidar tus citas. Nuestra aplicación te notifica',
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xffffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                'Datos del negocio',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xff57636c),
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Foto del negocio (obligatorio)',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xff57636c),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.amber,
                ),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.amberAccent,
                        /*image: DecorationImage(
                            image: AssetImage('lib/assets/SplashScreen.jpg'),
                            fit: BoxFit.fill,
                          ),*/
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Subir imagen'),
                    )
                  ],
                ),
              ),
              Text(
                'Llene los siguientes campos',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xff57636c),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 1,
                controller: businessNameController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'No puedes dejar este campo vacío';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  label: Text('Nombre del negocio'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 1,
                controller: businessCategorieController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'No puedes dejar este campo vacío';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  label: Text('Categoría del negocio'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 1,
                controller: emailController,
                validator: (String? value) {
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  label: Text('Correo (opcional)'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 1,
                controller: telController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor escribe un número de contacto';
                  } else if (value.length == 8) {
                    return 'La contraseña debe tener 8 carácteres';
                  }
                  return null;
                },
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  label: Text('Número de contacto'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                maxLines: 1,
                controller: physicalDirectionController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'No puedes dejar este campo vacío';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  label: Text('Dirección física del negocio'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
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
                  controller: geographicalDirectionController,
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    label: Text('Dirección geográfica'),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                selectionHeightStyle: BoxHeightStyle.includeLineSpacingTop,
                controller: descriptionController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'No puedes dejar este campo vacío';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  label: Text('Descripción del negocio'),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  if (signUpKey.currentState!.validate()) {
                    ref.read(businessProvider.notifier).agregarNegocio(
                        businessNameController.text,
                        businessCategorieController.text,
                        0,
                        0,
                        5,
                        'S');
                    Navigator.pop(context);
                  }
                },
                child: Text('Registrar negocio'),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
