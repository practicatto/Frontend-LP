import 'package:abonet/models/Categoria.dart';
import 'package:abonet/ui/cardGeneric.dart';
import 'package:flutter/material.dart';

class Categorias extends StatefulWidget {
  final List<Categoria> data = [
    Categoria(1, "Leyes", "Leyes basicas"),
    Categoria(2, "Civil", "Leyes para el pueblo"),
    Categoria(3, "Accidente de transito", "Leyes para transito"),
    Categoria(4, "Derecho Laboral", "Leyes para trabajadores"),
    Categoria(5, "Derecho penal", "Leyes penales"),
  ];

  Categorias({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  List<Widget> generarCards() {
    List<Widget> lista = [];
    widget.data.forEach((element) {
      lista.add(CardGeneric(
        title: element.nombre,
      ));
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
