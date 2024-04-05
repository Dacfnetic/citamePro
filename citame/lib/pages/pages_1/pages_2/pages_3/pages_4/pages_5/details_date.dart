
import 'dart:typed_data';
import 'package:citame/models/worker_moder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class DetailsDate extends ConsumerWidget {
  const DetailsDate(
      {super.key, required this.imagen, required this.trabajador});

  final Uint8List imagen;
  final Worker trabajador;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usuario user = ref.read(myBustieinessStateProvider.notifier).getDatosUsuario();

    return Scaffold( 
      appBar: AppBar(
        title: Text('detalles cita')
        ),
        body: SafeArea(child: Column(
          mainAxisSize: MainAxisSize.max ,
          children: [],
        )),
        );
     }
    }