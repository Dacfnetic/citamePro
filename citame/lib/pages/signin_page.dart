import 'dart:convert';
import 'package:citame/models/user_model.dart';
import 'package:citame/firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:citame/pages/business_registration_page.dart';
import 'package:citame/pages/home_page.dart';
import 'package:citame/pages/login_page.dart';
import 'package:citame/providers/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    const String serverUrl = 'http://192.168.0.6:4000';
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

    Future<Usuario> addUser(String googleId, String? userName,
        String? emailUser, String? avatar) async {
      final response =
          await http.post(Uri.parse('$serverUrl/api/user-model/create'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'googleId': googleId,
                'UserName': userName,
                'EmailUser': emailUser,
                'avatar': avatar,
              }));

      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(response.body);
        final Usuario user = Usuario.fromJson(json);
        return user;
      } else {
        throw Exception('Failed to add item');
      }
    }

    final FirebaseFirestore fireStore = FirebaseFirestore.instance;

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
                            print('object');
                            if (context.mounted) {
                              addUser(
                                  userCredential.user!.uid,
                                  userCredential.user!.displayName,
                                  userCredential.user!.email,
                                  userCredential.user!.photoURL);
                            }

                            /*fireStore
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'uid': userCredential.user!.uid,
                              'email': userCredential.user!.email,
                              'displayName': userCredential.user!.displayName,
                            }, SetOptions(merge: true));*/
                            if (context.mounted) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ));
                            }
                          } catch (e) {
                            if (context.mounted) {
                              print('este');
                              print('este');
                              print('este');
                              print('este');
                              print('este');
                              print(e.toString());
                              print('este');
                              print('este');
                              print('este');
                              print('este');
                              print('este');
                              /*StatusAlert.show(
                                context,
                                duration: const Duration(seconds: 2),
                                title: 'User Authentication',
                                subtitle: e.toString(),
                                configuration: const IconConfiguration(
                                  icon: Icons.close,
                                  color: Colors.red,
                                ),
                              );*/
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
                            fireStore
                                .collection('users')
                                .doc(userCredential.user!.uid)
                                .set({
                              'uid': userCredential.user!.uid,
                              'email': userCredential.user!.email,
                              'displayName': userCredential.user!.displayName,
                            }, SetOptions(merge: true));
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
