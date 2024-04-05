
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
        title: Text('Detalles cita', style: TextStyle(fontWeight: FontWeight.bold),)
        ),
        body: SafeArea(child: Column(
          mainAxisSize: MainAxisSize.max ,
          children: [
                   
                   Container(
                    margin: EdgeInsets.only(right: 40, left: 40),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(7)),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                           
                          Container(
                            padding: EdgeInsets.all(2),
                            child: CircleAvatar( radius: 25, // ajusta el tamaño del avatar según tus necesidades
           // backgroundImage: NetworkImage('https://ejemplo.com/imagen.jpg'), // URL de la imagen del avatar
            backgroundColor: Colors.black)),
                           SizedBox(width:20),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('arath de la torre'),
                            Text('arathdelatorre@gmail.com', style: TextStyle(color: Colors.grey),)       
                         ],)
                       

                    ],) ,
                   )

          ],
        )),
        );
     }
    }