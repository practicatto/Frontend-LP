import 'package:flutter/material.dart';

class Ciudades extends StatefulWidget {
  Ciudades({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CiudadesState createState() => _CiudadesState();
}

class _CiudadesState extends State<Ciudades> {
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
                'Ciudades',
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
