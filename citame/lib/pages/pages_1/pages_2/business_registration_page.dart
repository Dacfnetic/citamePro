import 'dart:io';
import 'package:citame/Widgets/cuadro.dart';
import 'package:citame/Widgets/cuadro_celular.dart';
import 'package:citame/Widgets/cuadro_dropdown.dart';
import 'package:citame/Widgets/cuadro_opcional.dart';
import 'package:citame/Widgets/photo_container.dart';
import 'package:citame/Widgets/universal_variables.dart';
import 'package:citame/pages/pages_1/pages_2/map_page.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/menu_page.dart';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/providers/marker_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:citame/services/business_services/post_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessRegisterPage extends ConsumerWidget {
  BusinessRegisterPage({
    super.key,
  });

  // #region declaración de controladores de texto
  final TextEditingController description = TextEditingController();
  final TextEditingController businessName = TextEditingController();
  final TextEditingController physicalDirection = TextEditingController();
  final TextEditingController geographicalDirection = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController cel = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  // #endregion

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Marker negocio = ref.watch(markerProvider);

    CuadroDropdown categoria = CuadroDropdown(
      control: category,
      texto: GlobalVariables.categorias[0],
      opciones: GlobalVariables.categorias,
    );

    final indicaciones = GoogleFonts.plusJakartaSans(
      color: Color(0xff57636c),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        businessName.text = '';
        cel.text = '';
        physicalDirection.text = '';
        description.text = '';
        ref.read(imgProvider.notifier).changeState(File(''));
      },
      child: Scaffold(
        body: Form(
          key: signUpKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text(
                      'Datos del negocio',
                      style: MediaQuery.of(context).size.width < 100
                          ? API.estiloJ14negro
                          : API.estiloJ24negro,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.info)),
                  ],
                ),

                Text('Foto del negocio (obligatorio)', style: indicaciones),
                EspacioParaSubirFotoDeNegocio(),
                Text('Llene los siguientes campos', style: indicaciones),
                SizedBox(height: 12),
                Cuadro(control: businessName, texto: 'Nombre del negocio'),
                SizedBox(height: 12),
                Text('Categoría del negocio', style: indicaciones),
                categoria,
                SizedBox(height: 12),
                CuadroOpcional(control: email, texto: 'Correo (opcional)'),
                SizedBox(height: 12),
                CuadroCelular(control: cel, texto: 'Número de contacto'),
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
                    if (ref.read(imgProvider).path != '') {
                      try {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (signUpKey.currentState!.validate()) {
                          var idNegocio = '';
                          idNegocio = await PostBusiness.postBusiness(
                              businessName.text,
                              categoria.texto,
                              prefs.getString('emailUser')!,
                              //auth.currentUser!.uid,
                              cel.text,
                              physicalDirection.text,
                              negocio.position.latitude.toString(),
                              negocio.position.longitude.toString(),
                              description.text,
                              ref.read(imgProvider),
                              'business');
                          if (context.mounted) {
                            ref
                                .read(myBusinessStateProvider.notifier)
                                .setActualBusiness(idNegocio);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuPage(),
                                ));
                          }
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    } else {
                      API.mensaje2(context, 'Tienes que subir una imagen');
                    }
                  },
                  child: Text('Registrar negocio'),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
