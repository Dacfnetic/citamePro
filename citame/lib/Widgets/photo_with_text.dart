import 'package:flutter/material.dart';

class FotoConTexto extends StatelessWidget {
  const FotoConTexto({
    super.key,
    required this.estilo,
    required this.mensaje,
  });

  final TextStyle estilo;
  final String mensaje;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/Splashscreen.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Text(mensaje, style: estilo),
    );
  }
}
