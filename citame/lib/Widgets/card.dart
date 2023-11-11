import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  const Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        height: 240,
        width: 150,
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          border: Border.all(
            width: 8,
          ),
          borderRadius: BorderRadius.circular(36),
        ),
      ),
    );
  }
}
