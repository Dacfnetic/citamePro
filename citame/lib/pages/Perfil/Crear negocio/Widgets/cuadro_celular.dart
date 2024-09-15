import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class CuadroCelular extends StatefulWidget {
  CuadroCelular({
    super.key,
    required this.control,
    required this.texto,
  });

  final TextEditingController control;
  final String texto;

  @override
  State<CuadroCelular> createState() => _CuadroCelularState();
}

class _CuadroCelularState extends State<CuadroCelular> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      controller: widget.control,
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'No puedes dejar este campo vacío';
        }
        if (value.length != 8) {
          return 'El celular debe tener 8 dígitos';
        }
        if (!isNumeric(value)) {
          return 'No se admiten carácteres no númericos';
        }
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
