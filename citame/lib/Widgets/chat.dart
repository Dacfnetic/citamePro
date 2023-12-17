import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class ChatSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: ClipPath(
            clipper: UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: Text(
                "hey how are you",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
