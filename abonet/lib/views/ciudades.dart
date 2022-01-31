import 'package:abonet/models/Ciudad.dart';
import 'package:abonet/services/api_service.dart';
import 'package:abonet/ui/LoadingView.dart';
import 'package:abonet/ui/cardCiudadesc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ciudades extends StatelessWidget {
  Ciudades({Key? key}) : super(key: key);

  List<Widget> generarCards(List<Ciudad> data) {
    List<Widget> lista = [];
    data.forEach((element) {
      lista.add(CardCiudad(title: element.nombre));
    });
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    final ciudades = Provider.of<ApiService>(context);

    if (ciudades.isLoading) return LoadingView();

    return Container(
        child: Center(
      child: ListView(
        children: <Widget>[
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: generarCards(ciudades.ciudades),
          )
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
