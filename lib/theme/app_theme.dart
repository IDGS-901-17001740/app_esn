import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFB88736);
  static const Color secundary = Color(0xFFB6AC9D);
  static const Color third = Color(0xFF9C8C72);
  static const Color fourth = Color(0xFFD9DAD9);
  static const Color fifth = Color(0xFF000000);
  static const Color sixth = Color(0xFFF1F1F1);
  static const Color red = Color(0xFFF53E3E);

  static InputDecoration baseInput(
      {required String hintText,
      required String labelText,
      required IconData icon,
      Widget? iconButton}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: third,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        color: secundary,
      ),
      prefixIcon: Icon(
        icon,
        color: third,
      ),
      suffixIcon: iconButton,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: third,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: third, width: 2),
      ),
    );
  }
}
