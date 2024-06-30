import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

// ignore: must_be_immutable
class CuadroDropdown extends StatefulWidget {
  CuadroDropdown({
    super.key,
    required this.control,
    required this.texto,
    required this.opciones,
  });

  final TextEditingController control;
  String texto;
  final List<String> opciones;

  @override
  State<CuadroDropdown> createState() => _CuadroDropdownState();
}

class _CuadroDropdownState extends State<CuadroDropdown> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> opciones = [];

    for (var opcion in widget.opciones) {
      opciones.add(DropdownMenuItem(value: opcion, child: Text(opcion)));
    }
    String dropdownValue = widget.opciones[0];

    return Center(
      child: DropdownButtonFormField<String>(
        value: dropdownValue,
        items: opciones,
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            widget.texto = value;
            API.cat(dropdownValue);
          });
        },
      ),
    );
  }
}
