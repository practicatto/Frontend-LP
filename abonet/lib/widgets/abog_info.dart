import 'package:abonet/models/Comentario.dart';
import 'package:abonet/services/api_service.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AbogInfo extends StatelessWidget {
  final int abogadoId;
  const AbogInfo(this.abogadoId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
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

// ignore: must_be_immutable
class MainContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  late double calfComent = 3.5;

  MainContainer(this.data, {Key? key}) : super(key: key);

  final myController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          listProfAttrs(data),
          estrellas(data["calificacion"].toDouble()),
          SizedBox(
            height: 20,
          ),
          writeComment(context, data["id"].toString()),
          cargarComentarios(context)
        ],
      ),
    );
  }

  Widget cardComment(Comentario c, BuildContext context) {
    final api = Provider.of<ApiService>(context);

    return FutureBuilder<String>(
      future: api.getUsuario(c.idUser),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> lista = [];
        if (snapshot.hasData) {
          String nombre = snapshot.data!;
          return Card(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.account_circle_rounded, size: 40),
                            SizedBox(width: 10),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(nombre,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  estrellas(c.calificacion)
                                ]),
                          ]),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Expanded(
                          child: Text(
                            c.mensaje,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ])
                    ],
                  )));
        } else if (snapshot.hasError) {
          print(snapshot.error);
          lista = [
            Container(
              child: Text("$snapshot.error"),
            )
          ];
        } else {
          lista = [
            Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            )
          ];
        }
        return Column(
          children: lista,
        );
      },
    );
  }

  Column cargarComentarios(BuildContext context) {
    final api = Provider.of<ApiService>(context);
    return Column(
      children: [
        FutureBuilder<List<Comentario>>(
            future: api.getComments(data["id"]),
            builder: (BuildContext context,
                AsyncSnapshot<List<Comentario>> snapshot) {
              List<Widget> lista = [];
              if (snapshot.hasData) {
                lista = [];
                snapshot.data?.forEach((element) {
                  lista.add(cardComment(element, context));
                });
                return Column(
                  children: lista,
                );
              } else if (snapshot.hasError) {
                lista = [Container()];
              } else {
                lista = [
                  Center(
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                  )
                ];
              }
              return Column(
                children: lista,
              );
            })
      ],
    );
  }

  Widget listProfAttrs(data) {
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
              : "Sin telefono"),
      ElevatedButton(
        onPressed: () => launch("tel://${data["telefono"][0]["telefono"]}"),
        child: Text("Llamar"),
      ),
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

  Widget writeComment(BuildContext context, String abogadoId) {
    if (Home.isAbogado) return Container();

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
                        controller: myController,
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
                        onPressed: () async {
                          final api =
                              Provider.of<ApiService>(context, listen: false);
                          final auth =
                              Provider.of<AuthService>(context, listen: false);
                          String id = await auth.readId();
                          api.postComentario(abogadoId, id, myController.text,
                              calfComent.toString());
                        })
                  ])
                ],
              )))
    ]);
  }

  Widget cuatroEstrellas() {
    return RatingBar.builder(
        allowHalfRating: true,
        itemCount: 5,
        initialRating: calfComent,
        itemSize: 20,
        itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.secondary,
            ),
        onRatingUpdate: (valor) {
          calfComent = valor;
        });
  }

  Widget estrellas(double calificacion) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Calificacion: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Column(
          children: [
            RatingBarIndicator(
              itemCount: 5,
              itemSize: 28,
              rating: calificacion,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(calificacion.toString(), style: TextStyle(fontSize: 12))
          ],
        ),
      ],
    );
  }
}
