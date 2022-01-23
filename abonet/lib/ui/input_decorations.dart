import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xffeb9405)),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffeb9405), width: 2)),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: Color(0xffa56d51)),
    );
  }
}