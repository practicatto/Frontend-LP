import 'package:abonet/models/Ciudad.dart';
import 'package:abonet/ui/cardGeneric.dart';
import 'package:flutter/material.dart';

class Ciudades extends StatefulWidget {
  final List<Ciudad> ciudades = [
    Ciudad(1, "Guayaquil"),
    Ciudad(2, "Salinas"),
    Ciudad(3, "Quito"),
    Ciudad(4, "Manta")
  ];

  Ciudades({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CiudadesState createState() => _CiudadesState();
}

class _CiudadesState extends State<Ciudades> {
  List<Widget> generarCards() {
    List<Widget> lista = [];
    widget.ciudades.forEach((element) {
      lista.add(CardGeneric(title: element.nombre));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: generarCards(),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
