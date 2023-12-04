import 'dart:convert';
import 'package:citame/firebase_options.dart';
import 'package:citame/models/business_model.dart';
import 'package:citame/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

String serverUrl = 'https://ubuntu.citame.store';
FirebaseAuth auth = FirebaseAuth.instance;

abstract class API {
  static Future<String> postUser(String googleId, String? userName,
      String? emailUser, String? avatar) async {
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

  static Future<List<Business>> getOwnerBusiness() async {
    var email = auth.currentUser!.email;
    final response = await http.get(
        Uri.parse('$serverUrl/api/business/get/owner'),
        headers: {'email': email!});
    if (response.statusCode == 200) {
      final List<dynamic> businessList = jsonDecode(response.body);
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();
      return businesses;
    }
    throw Exception('Failed to get items');
  }

  static Future<List<Business>> getAllBusiness() async {
    var email = auth.currentUser!.email;
    final response = await http.get(
        Uri.parse('$serverUrl/api/business/get/all'),
        headers: {'email': email!});
    if (response.statusCode == 200) {
      final List<dynamic> businessList = jsonDecode(response.body);
      final List<Business> businesses = businessList.map((business) {
        Business negocio = Business.fromJson(business);
        return negocio;
      }).toList();
      return businesses;
    }
    throw Exception('Failed to get items');
  }

  static Future<Usuario> getUser() async {
    final response = await http.get(Uri.parse('$serverUrl/api/user/get'),
        headers: {'googleId': auth.currentUser!.uid});
    if (response.statusCode == 200) {
      final List<dynamic> usuarios = jsonDecode(response.body);
      final Usuario usuario = Usuario(
          googleId: usuarios[0]['googleId'],
          userName: usuarios[0]['userName'],
          userEmail: usuarios[0]['emailUser'],
          avatar: usuarios[0]['avatar']);
      return usuario;
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
  ) async {
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

  static var estiloJ24negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF14181B), fontSize: 24, fontWeight: FontWeight.w500);
  static var estiloJ14negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF15161E), fontSize: 14, fontWeight: FontWeight.w500);
  static var estiloJ14gris = GoogleFonts.plusJakartaSans(
      color: Color(0xFF606A85), fontSize: 14, fontWeight: FontWeight.w500);
  static var estiloJ16negro = GoogleFonts.plusJakartaSans(
      color: Color(0xFF14181B), fontSize: 16, fontWeight: FontWeight.normal);
}
