import 'package:flutter/material.dart';

class CuadroDescription extends StatefulWidget {
  CuadroDescription({
    super.key,
    required this.control,
    required this.texto,
  });

  final TextEditingController control;
  final String texto;

  @override
  State<CuadroDescription> createState() => _CuadroDescriptionState();
}

class _CuadroDescriptionState extends State<CuadroDescription> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: TextFormField(
      controller: widget.control,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'No puedes dejar este campo vacío';
        }
        return null;
      },
      maxLines: 7,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        label: Text(widget.texto),
      ),
    ));
  }
}
