import 'package:citame/firebase_options.dart';
import 'package:citame/pages/business_registration_page.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/pages/login_page.dart';
import 'package:citame/providers/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:status_alert/status_alert.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<UserCredential> signInWithGoogle() async {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId: (DefaultFirebaseOptions.currentPlatform ==
                      DefaultFirebaseOptions.ios)
                  ? DefaultFirebaseOptions.currentPlatform.iosClientId
                  : DefaultFirebaseOptions.currentPlatform.androidClientId)
          .signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    Future<UserCredential> signInWithFacebook() async {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
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
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        icon: Icon(Icons.email),
                        label: Text("Iniciar sesión con correo eléctronico"),
                        onPressed: () {
                          ref.read(loginProvider.notifier).changeState();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                      ),
                    ),
                    Text(
                      'O entrar con',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        icon: FaIcon(FontAwesomeIcons.google),
                        label: Text("Iniciar sesión con Google"),
                        onPressed: () async {
                          try {
                            final UserCredential userCredential =
                                await signInWithGoogle();
                            if (context.mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            }
                          } catch (e) {
                            if (context.mounted) {
                              print(e);
                              StatusAlert.show(
                                context,
                                duration: const Duration(seconds: 2),
                                title: 'User Authentication',
                                subtitle: e.toString(),
                                configuration: const IconConfiguration(
                                  icon: Icons.close,
                                  color: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue)),
                        icon: FaIcon(FontAwesomeIcons.facebook),
                        label: Text("Iniciar sesión con Facebook"),
                        onPressed: () async {
                          try {
                            final UserCredential userCredential =
                                await signInWithFacebook();
                            if (context.mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }
                          } catch (e) {
                            if (context.mounted) {
                              print(e.toString());
                              StatusAlert.show(context,
                                  duration: const Duration(seconds: 2),
                                  title: 'User Authentication',
                                  subtitle: e.toString(),
                                  configuration: const IconConfiguration(
                                      icon: Icons.close, color: Colors.red),
                                  maxWidth: 360);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusinessRegisterPage(),
                        ));
                  },
                  child: Text('No tenes cuenta perro, registrate aca'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}