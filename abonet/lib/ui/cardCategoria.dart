import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardCategoria extends StatelessWidget {
  final String title;

  const CardCategoria({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: _boxDecoration(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ImageLogo(name: this.title),
              Center(
                  child: Text(
                this.title,
                style: _estiloTexto(),
              ))
            ],
          ),
        ));
  }

  TextStyle _estiloTexto() =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);

  BoxDecoration _boxDecoration(BuildContext context) => BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
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
      child: Center(
        child: SvgPicture.asset(
          "lib/images/Iconos/${this.name.replaceAll(" ", "")}.svg",
          height: 80,
          width: 70,
          color: Colors.white,
        ),
      ),
    );
  }
}
