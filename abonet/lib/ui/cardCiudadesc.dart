import 'package:flutter/material.dart';

class CardCiudad extends StatelessWidget {
  final String title;

  const CardCiudad({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: _boxDecoration(),
      child: Column(
        children: [
          _ImageLogo(name: this.title),
          Center(child: Text(this.title))
        ],
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

// ignore: must_be_immutable
class _ImageLogo extends StatelessWidget {
  String name;

  _ImageLogo({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 80,
      child: Image.asset("lib/images/banderas/${this.name}.png"),
    );
  }
}
