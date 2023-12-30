// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ChatBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Color de la sombra
            spreadRadius: 5, // Radio de propagación de la sombra
            blurRadius: 7, // Radio de desenfoque de la sombra
            offset: Offset(0, 3), // Desplazamiento de la sombra en (x, y)
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 2, top: 5),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.emoji_emotions),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: TextFormField(
                minLines: 1,
                maxLines: 7,
                //scrollPhysics: NeverScrollableScrollPhysics(),
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  labelText: 'Escribir mensaje',
                  hintText: '',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
