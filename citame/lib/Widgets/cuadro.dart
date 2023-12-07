import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Cuadro extends StatefulWidget {
  Cuadro({
    super.key,
    required this.control,
    required this.texto,
  });

  final TextEditingController control;
  final String texto;

  @override
  State<Cuadro> createState() => _CuadroState();
}

class _CuadroState extends State<Cuadro> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Doctores y dentistas';

    if (widget.texto == "Categoría del negocio") {
      return Center(
        child: DropdownButtonFormField<String>(
          value: dropdownValue,
          items: [
            DropdownMenuItem(
              value: 'Abogados',
              child: Text('Abogados'),
            ),
            DropdownMenuItem(
              value: 'Barberias',
              child: Text('Barberias'),
            ),
            DropdownMenuItem(
              value: 'Belleza',
              child: Text('Belleza'),
            ),
            DropdownMenuItem(
              value: 'Doctores y dentistas',
              child: Text('Doctores y dentistas'),
            ),
            DropdownMenuItem(
              value: 'Entretenimiento',
              child: Text('Entretenimiento'),
            ),
            DropdownMenuItem(
              value: 'Mecanicos',
              child: Text('Mecanicos'),
            )
          ],
          onChanged: (String? value) {
            setState(() {
              dropdownValue = value!;
              API.cat(dropdownValue);
            });
          },
        ),
      );
    }

    return TextFormField(
      maxLines: 1,
      controller: widget.control,
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
        label: Text(widget.texto),
      ),
    );
  }
}
