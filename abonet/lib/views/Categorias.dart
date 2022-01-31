import 'package:abonet/models/Categoria.dart';
import 'package:abonet/ui/LoadingView.dart';
import 'package:abonet/ui/cardCategoria.dart';
import 'package:flutter/material.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:provider/provider.dart';

class Categorias extends StatefulWidget {
  Categorias({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  List<Widget> generarCards(List<Categoria> data) {
    List<Widget> lista = [];
    data.forEach((element) {
      lista.add(CardCategoria(
        title: element.nombre,
      ));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<AuthService>(context);

    if (categorias.isLoading) return LoadingView();

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
                children: generarCards(categorias.categorias),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
