import 'package:abonet/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbogInfo extends StatelessWidget {
  final int abogadoId;
  const AbogInfo(this.abogadoId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Abogado"),
      ),
      body: futureWidget(apiService),
    );
  }

  FutureBuilder<Map<String, dynamic>> futureWidget(ApiService apiService) {
    return FutureBuilder<Map<String, dynamic>>(
        future: apiService.getAbogadoById(abogadoId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return MainContainer(snapshot.data!);
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class MainContainer extends StatelessWidget {
  final Map<String, dynamic> data;

  const MainContainer(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [listProfAttrs(data), writeComment()],
      ),
    );
  }

  Widget listProfAttrs(data) {
    print(data["categoria"]);
    var categoriasNombres = data.containsKey("categoria")
        ? data["categoria"].map((cat) => cat["nombre"]).toList().join(", ")
        : "";
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text("${data["nombre_completo"]}",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      Icon(Icons.account_box, size: 120),
      profAttrUniq(
          "Ciudad",
          data.containsKey("ubicacion") && data["ubicacion"].length > 0
              ? data["ubicacion"][0]["ciudad"]
              : ""),
      profAttrUniq(
          "Direccion",
          data.containsKey("ubicacion") && data["ubicacion"].length > 0
              ? data["ubicacion"][0]["direccion"]
              : ""),
      profAttrUniq("Categorías", categoriasNombres),
      profAttrUniq("Mail", data["correo"]),
      profAttrUniq(
          "Celular",
          data.containsKey("telefono") && data["telefono"].length > 0
              ? data["telefono"][0]["telefono"]
              : ""),
    ]);
  }

  Widget profAttrUniq(attr, value) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("$attr: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text("$value", style: TextStyle(fontSize: 16)),
        ]));
  }

  Widget writeComment() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text("Opiniones",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      Card(
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.account_circle_rounded, size: 50),
                        SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Yo",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              cuatroEstrellas()
                            ]),
                      ]),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Expanded(
                      child: TextField(
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Comentario',
                        ),
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.send),
                        onPressed: () {})
                  ])
                ],
              )))
    ]);
  }

  Widget cuatroEstrellas() {
    return Row(
        children: List.filled(4, Icon(Icons.star_outlined)) +
            [Icon(Icons.star_outline)]);
  }
}
