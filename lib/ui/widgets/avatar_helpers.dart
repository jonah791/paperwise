import 'package:flutter/material.dart';

Widget buildDefaultAvatar(String name, double size, int colorArgb) {
  final char = name.isNotEmpty ? name.characters.first : '?';
  final color = Color(colorArgb);

  return CircleAvatar(
    radius: size / 2,
    backgroundColor: color,
    child: Text(
      char,
      style: TextStyle(
        color: Colors.white,
        fontSize: size * 0.45,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
