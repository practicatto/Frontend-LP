import 'package:flutter/material.dart';

class CardGeneric extends StatelessWidget {
  final String title;

  const CardGeneric({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: _boxDecoration(),
      child: Stack(
        children: [Center(child: Text(this.title))],
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}
