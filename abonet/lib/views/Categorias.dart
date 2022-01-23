import 'package:flutter/material.dart';

class Categorias extends StatefulWidget {
  Categorias({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Categorias',
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
