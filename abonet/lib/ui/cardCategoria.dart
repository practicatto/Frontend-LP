import 'package:abonet/models/Categoria.dart';

import 'package:abonet/views/SelectCategoriaView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardCategoria extends StatelessWidget {
  final Categoria categoria;

  const CardCategoria({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      SelectCategoria(categoria: this.categoria),
                  transitionDuration: Duration(seconds: 0)));
        },
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: _boxDecoration(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ImageLogo(name: this.categoria.nombre),
              Center(
                  child: Text(
                this.categoria.nombre,
                style: _estiloTexto(),
              ))
            ],
          ),
        ));
  }

  TextStyle _estiloTexto() =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

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
      child: Center(
        child: SvgPicture.asset(
          "lib/images/Iconos/${this.name.replaceAll(" ", "")}.svg",
          height: 80,
          width: 70,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
