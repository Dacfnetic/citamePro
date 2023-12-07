import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:citame/firebase_options.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/models/user_model.dart';
import 'package:citame/pages/pages_1/pages_2/business_registration_page.dart';
import 'package:citame/providers/img_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String serverUrl = 'https://ubuntu.citame.store';
FirebaseAuth auth = FirebaseAuth.instance;
String actualCat = '';
String categoriaABuscar = '';

abstract class API {
  static Future<String> postUser(String googleId, String? userName,
      String? emailUser, String? avatar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('googleId') == null ||
        prefs.getString('googleId') != googleId) {
      prefs.setString('googleId', googleId);
    }
    if (prefs.getString('userName') == null ||
        prefs.getString('userName') != userName) {
      prefs.setString('userName', userName!);
    }
    if (prefs.getString('emailUser') == null ||
        prefs.getString('emailUser') != emailUser) {
      prefs.setString('emailUser', emailUser!);
    }
    if (prefs.getString('avatar') == null ||
        prefs.getString('avatar') != avatar) {
      prefs.setString('avatar', avatar!);
    }
    final response = await http.post(Uri.parse('$serverUrl/api/user/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'googleId': googleId,
          'userName': userName,
          'emailUser': emailUser,
          'avatar': avatar,
        }));
    if (response.statusCode == 201) return 'Todo ok';
    if (response.statusCode == 202) return 'Todo ok';
    throw Exception('Failed to add item');
  }

  static Future pickImageFromGallery(WidgetRef ref) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    var comprimida = await FlutterImageCompress.compressAndGetFile(
        returnedImage!.path, '${returnedImage.path}compressed.jpg',
        minHeight: 640, minWidth: 480, quality: 80);

    if (comprimida != null) {
      final camino = comprimida.path;
      ref.watch(imgProvider.notifier).changeState(camino);
    }
  }

  static Future<List<Business>> getOwnerBusiness(
      BuildContext context, WidgetRef ref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await verifyOwnerBusiness();
    var estado = prefs.getString('ownerBusinessStatus');
    var email = prefs.getString('emailUser');
    final response = await http.get(
        Uri.parse('$serverUrl/api/business/get/owner'),
        headers: {'email': email!, 'estado': estado!});

    if (response.statusCode == 201) {
      final List<dynamic> businessList = jsonDecode(response.body);
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();

      List<String> aGuardar = businesses.map((e) => jsonEncode(e)).toList();
      prefs.setStringList('negocios', aGuardar);

      ref.read(myBusinessStateProvider.notifier).cargar(businesses);
      if (context.mounted) {
        if (businesses.length == 0) {
          API.noHayPropios(context);
        }
      }
      final List<String> nombres =
          businesses.map((neg) => neg.businessName).toList();
      prefs.setStringList('ownerBusiness', nombres);

      return businesses;
    }

    if (response.statusCode == 200) {
      List<Business> negocios = prefs
          .getStringList('negocios')!
          .map((e) => Business.fromJson(jsonDecode(e)))
          .toList();
      print(negocios);
      if (context.mounted) {
        if (prefs.getStringList('ownerBusiness')!.length == 0) {
          API.noHayPropios(context);
        }
      }
      return negocios;
    }
    throw Exception('Failed to get items');
  }

  static Future<void> verifyOwnerBusiness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('ownerBusiness') == null) {
      prefs.setStringList('ownerBusiness', []);
    }

    var nombres = prefs.getStringList('ownerBusiness');
    var email = prefs.getString('emailUser');
    final response = await http.post(
        Uri.parse('$serverUrl/api/business/verify/owner/business'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "businessName": nombres,
          "email": email,
        }));
    if (response.statusCode == 201) {
      //No son iguales o no hay negocios
      prefs.setString('ownerBusinessStatus', '0');
      //prefs.setStringList('ownerBusiness', []);
      return;
    }
    if (response.statusCode == 200) {
      prefs.setString('ownerBusinessStatus', '1');

      return;
    }
    throw Exception('Failed to get items');
  }

  static Future<List<Business>> getAllBusiness(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('emailUser');

    final response = await http.get(
      Uri.parse('$serverUrl/api/business/get/all'),
      headers: {
        'email': email!,
        'category': categoriaABuscar,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> businessList = jsonDecode(response.body);
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();
      if (context.mounted) {
        if (businesses.length == 0) {
          API.noHay(context);
        }
      }

      return businesses;
    }

    throw Exception('Failed to get items');
  }

  static Future<Usuario> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(auth);
    final response = await http.get(Uri.parse('$serverUrl/api/user/get'),
        headers: {'googleId': prefs.getString('googleId')!});
    if (response.statusCode == 200) {
      final Usuario usuario = Usuario(
          googleId: prefs.getString('googleId')!,
          userName: prefs.getString('userName')!,
          userEmail: prefs.getString('emailUser')!,
          avatar: prefs.getString('avatar')!);
      return usuario;
    }
    throw Exception('Failed to get items');
  }

  static Future<List<String>> getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$serverUrl/api/user/get/all'),
        headers: {'googleId': prefs.getString('googleId')!});
    if (response.statusCode == 200) {
      final List<dynamic> userList = jsonDecode(response.body);
      final List<Usuario> usuarios = userList.map((user) {
        Usuario u = Usuario.fromJson(user);
        return u;
      }).toList();
      final List<String> nombres = usuarios.map((e) => e.userName).toList();
      return nombres;
    }
    throw Exception('Failed to get items');
  }

  static Future<String> postBusiness(
    String businessName,
    String? category,
    String? email,
    //String? createdBy,
    List<String> workers,
    String? contactNumber,
    String? direction,
    String? latitude,
    String? longitude,
    String? description,
    String imgPath,
  ) async {
    String imgConv = await API.convertTo64(imgPath);
    Uint8List casi = API.decode64(imgConv);
    List<int> imagen = casi.toList();

    final response =
        await http.post(Uri.parse('$serverUrl/api/business/create'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "businessName": businessName,
              "category": category,
              "email": email,
              //"createdBy": createdBy,
              "workers": workers,
              "contactNumber": contactNumber,
              "direction": direction,
              "latitude": latitude,
              "longitude": longitude,
              "description": description,
              "imgPath": imagen,
            }));
    if (response.statusCode == 201) return "Negocio creado";
    if (response.statusCode == 202) return "El negocio ya existe";
    throw Exception('Failed to add item');
  }

  static Future<UserCredential> signInWithGoogle() async {
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

  static Future<String> convertTo64(String imagepath) async {
    File imagefile = File(imagepath); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string =
        base64.encode(imagebytes); //convert bytes to base64 string
    print(base64string);
    return base64string;
  }

  static Uint8List decode64(String base64string) {
    Uint8List decodedbytes = base64.decode(base64string);
    return decodedbytes;
  }

  static cat(String cat) {
    actualCat = cat;
  }

  static setCat(String cat) {
    categoriaABuscar = cat;
  }

  static noHay(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text('No hay negocios'),
              content: Text(
                  'No hay nadie que sea dueño de este tipo de negocio según tus preferencias de busqueda, esta puede ser una gran oportunidad para tí, ¿quieres crear tu negocio?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessRegisterPage(),
                          ));
                    },
                    child: Text('Si'))
              ],
            ));
  }

  static timePicker(BuildContext context) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    return selectedTime;
  }

  static noHayPropios(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              elevation: 24,
              title: Text('Advertencia'),
              content: Text(
                  'No eres dueño ni empleado de ningún negocio, ¿quieres crear tu negocio?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessRegisterPage(),
                          ));
                    },
                    child: Text('Si'))
              ],
            ));
  }

  static String getCat() {
    return actualCat;
  }

  static var estiloJ24negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF14181B), fontSize: 24, fontWeight: FontWeight.w500);
  static var estiloJ14negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF15161E), fontSize: 14, fontWeight: FontWeight.w500);
  static var estiloJ14gris = GoogleFonts.plusJakartaSans(
      color: Color.fromRGBO(96, 106, 133, 1),
      fontSize: 14,
      fontWeight: FontWeight.w500);
  static var estiloJ16negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF14181B), fontSize: 16, fontWeight: FontWeight.normal);
}
