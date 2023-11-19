import 'package:citame/pages/pages_1/pages_2/business_registration_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/categories_provider.dart';
import 'package:citame/providers/maybe_not_password_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({
    super.key,
  });
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
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
                        'Inicie sesión',
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
                    ],
                  ),
                  Container(
                    height: 44,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(1)),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        textStyle: MaterialStatePropertyAll(
                          GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        backgroundColor: MaterialStatePropertyAll(
                          Color(0xff4b39ef),
                        ),
                      ),
                      onPressed: () async {
                        if (signUpKey.currentState!.validate()) {
                          try {
                            await auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            ref.read(businessProvider.notifier).inicializar();
                            ref.read(categoriesProvider.notifier).inicializar();
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Capaz y ese usuario no existe o te equivocaste de contraseña ${e.toString()}',
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text('Iniciar sesión'),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: '¿No tienes una cuenta? ',
                      ),
                      TextSpan(
                        text: 'Registrarse',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BusinessRegisterPage(),
                                ));
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
