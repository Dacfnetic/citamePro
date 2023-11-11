import 'package:citame/providers/password_provider.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

class BusinessRegisterPage extends ConsumerWidget {
  BusinessRegisterPage({
    super.key,
  });
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return Scaffold(
      body: Form(
        key: signUpKey,
        child: ListView(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crear una cuenta',
                        style: GoogleFonts.plusJakartaSans(
                          color: Color(0xff101213),
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
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
                        controller: firstNameController,
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
                          label: Text('Nombre'),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: lastNameController,
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
                          label: Text('Apellido'),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: emailController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'No puedes dejar este campo vacío';
                          } else if (!emailValid.hasMatch(value)) {
                            return 'Por favor escribe un email valido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          label: Text('Correo'),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: passwordController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor escribe una contraseña';
                          } else if (value.length < 6) {
                            return 'La contraseña debe tener más de 6 carácteres';
                          }
                          return null;
                        },
                        obscureText: !ref.watch(passProvider),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              ref.read(passProvider.notifier).changeState();
                            },
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              ref.watch(passProvider)
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          label: Text('Contraseña'),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        maxLines: 1,
                        controller: passwordCheckController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor escribe una contraseña';
                          } else if (value != passwordController.text) {
                            return 'Las contraseñas deben coincidir';
                          }
                          return null;
                        },
                        obscureText: !ref.watch(passProvider2),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () =>
                                ref.read(passProvider2.notifier).changeState(),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              ref.watch(passProvider2)
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: Color(0xFF57636C),
                              size: 24,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          label: Text('Confirmar contraseña'),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: '¿Ya tienes una cuenta? ',
                      ),
                      TextSpan(
                        text: 'Iniciar sesión',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
