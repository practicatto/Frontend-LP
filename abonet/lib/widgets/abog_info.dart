import 'package:abonet/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbogInfo extends StatelessWidget {
  final String abogadoId;
  const AbogInfo(this.abogadoId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    return FutureBuilder(
        future: apiService.getAbogadoById(abogadoId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return Text("Espere");
          } else
            return mainWidget(snapshot.data);
        });
  }

  Center mainWidget(data) {
    return Center(
        child: Column(children: [
      Text("${data["nombre_completo"]}",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      Icon(Icons.account_box, size: 120),
      listProfAttrs(data)
    ]));
  }

  Widget listProfAttrs(data) {
    var categoriasNombres =
        data["categoria"].map((cat) => cat["nombre"]).toList().join(", ");
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      profAttrUniq("Ciudad", data["ubicacion"][0]["ciudad"]),
      profAttrUniq("Categorías", categoriasNombres),
      profAttrUniq("Mail", data["correo"]),
      profAttrUniq("Celular", data["telefono"][0]["telefono"]),
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
}
