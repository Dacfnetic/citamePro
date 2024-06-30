import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class CuadroOpcional extends StatefulWidget {
  CuadroOpcional({
    super.key,
    required this.control,
    required this.texto,
  });

  final TextEditingController control;
  final String texto;

  @override
  State<CuadroOpcional> createState() => _CuadroOpcionalState();
}

class _CuadroOpcionalState extends State<CuadroOpcional> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: widget.control,
      validator: (String? value) {
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        label: Text(widget.texto),
      ),
    );
  }
}
