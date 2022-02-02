import 'package:abonet/models/Abogado.dart';
import 'package:abonet/models/Ciudad.dart';
import 'package:abonet/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:abonet/ui/cardAbogado.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectCiudad extends StatefulWidget {
  Ciudad ciudad;

  SelectCiudad({Key? key, required this.ciudad}) : super(key: key);

  @override
  State<SelectCiudad> createState() => _SelectCiudadState();
}

class _SelectCiudadState extends State<SelectCiudad> {
  @override
  Widget build(BuildContext context) {
    final abgCat = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ciudad.nombre),
      ),
      body: Center(
        child: ListView(
          children: [
            FutureBuilder<List<Abogado>>(
                future: abgCat.getAbogadosCiudad(widget.ciudad.nombre),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Abogado>> snapshot) {
                  List<Widget> abogados = [];
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    abogados =
                        data!.map((e) => cardAbogado(abogado: e)).toList();
                    ;
                  } else if (snapshot.hasError) {
                    abogados = [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ];
                    print(snapshot.error);
                  } else {
                    abogados = [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      )
                    ];
                  }
                  return Column(children: abogados);
                })
          ],
        ),
      ),
    );
  }
}
