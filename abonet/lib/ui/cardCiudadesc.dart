import 'package:abonet/models/Ciudad.dart';
import 'package:abonet/views/SelectCiudadView.dart';
import 'package:flutter/material.dart';

class CardCiudad extends StatelessWidget {
  final Ciudad ciudad;

  const CardCiudad({Key? key, required this.ciudad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      SelectCiudad(ciudad: this.ciudad),
                  transitionDuration: Duration(seconds: 0)));
        },
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: _boxDecoration(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ImageLogo(name: this.ciudad.nombre),
              Center(
                  child: Text(
                this.ciudad.nombre,
                style: _estiloTexto(),
              ))
            ],
          ),
        ));
  }

  TextStyle _estiloTexto() => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  BoxDecoration _boxDecoration(BuildContext context) => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
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
