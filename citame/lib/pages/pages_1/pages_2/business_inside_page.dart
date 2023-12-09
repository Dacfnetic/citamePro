import 'dart:typed_data';

import 'package:citame/Widgets/business_card.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/reservation_page.dart';
import 'package:citame/providers/own_business_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessInsidePage extends ConsumerWidget {
  BusinessInsidePage({
    Key? key,
    required this.businessName,
    required this.imagen,
    required this.description,
  }) : super(key: key);
  final String businessName;
  final Uint8List imagen;
  final String description;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<BusinessCard> negocios = ref.watch(ownBusinessProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(businessName, style: API.estiloJ24negro),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.memory(
                    imagen,
                    width: double.infinity,
                    height: 230,
                    fit: BoxFit.cover,
                  ),
                ),
                Text('Horario'),
                Text('Descripción'),
                Text(description, style: API.estiloJ14gris),
                Text('Servicios', style: API.estiloJ24negro),
                Text(
                    'Cargar desde backend tenemos que cambiar el modelo de negocio para agregarle los servicios',
                    style: API.estiloJ16negro),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReservationPage(),
                        ));
                  },
                  child: Row(
                    children: [
                      Expanded(child: Text('Foto')),
                      Expanded(
                          child: Column(
                        children: [
                          Text('Nombre del worker'),
                          Text('Puesto del worker')
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
