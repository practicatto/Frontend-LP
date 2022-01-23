import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final color;
  final text;
  final Function onPressed;
  const ButtonWidget(this.color, this.text, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 250,
      height: 45,
      onPressed: () => this.onPressed(),
      color: this.color,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        this.text,
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white70),
      ),
    );
  }
}
