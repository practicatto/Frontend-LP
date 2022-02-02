import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    IconData? icon,
    required String hintText,
    required String labelText,
  }) {
    final secondary = Color(0xffeb9405);
    final tertiary = Color(0xffa56d51);
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: secondary),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondary, width: 2)),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: tertiary),
      prefixIcon: icon != null ? Icon(icon, color: secondary) : null,
    );
  }
}
