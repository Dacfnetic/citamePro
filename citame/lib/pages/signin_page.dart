import 'package:citame/services/api_service.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/services/user_services/post_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // #region aquí va la imagen
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('lib/assets/Splashscreen.jpg'),
                  fit: BoxFit.fill,
                )),
                alignment: Alignment.bottomCenter,
                child: Text(
                  'CITAME',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            // #endregion
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(Colors.black),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.white)),
                      icon: FaIcon(FontAwesomeIcons.google),
                      label: Text("Iniciar sesión con Google"),
                      onPressed: () async {
                        try {
                          final UserCredential userCredential =
                              await API.signInWithGoogle();
                          await PostUser.postUser(
                            userCredential.user!.uid,
                            userCredential.user!.displayName,
                            userCredential.user!.email,
                            userCredential.user!.photoURL,
                          );
                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ));
                          }
                          //ref.read(ownBusinessProvider.notifier).cargar();
                        } catch (e) {
                          print(e.toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
