import 'package:flutter/material.dart';

class Cuadro extends StatelessWidget {
  const Cuadro({
    super.key,
    required this.control,
    required this.texto,
  });

  final TextEditingController control;
  final String texto;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: control,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'No puedes dejar este campo vacío';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        label: Text(texto),
      ),
    );
  }
}
