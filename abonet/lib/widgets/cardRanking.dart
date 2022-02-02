import 'package:abonet/models/Abogado.dart';
import 'package:flutter/material.dart';

class CardRanking extends StatelessWidget {
  final Abogado abogado;
  Widget _starsForRatings(context) {
    List<Widget> list = [];
    for (int i = 0; i < abogado.calificacion; i++) {
      list.add(
          Icon(Icons.star, color: Theme.of(context).colorScheme.secondary));
    }
    for (int i = 0; i < 5 - abogado.calificacion; i++) {
      list.add(Icon(Icons.star_border, color: Colors.grey));
    }
    list.add(const SizedBox(width: 5));

    list.add(Text(
      abogado.calificacion.toString(),
      style: TextStyle(color: Colors.grey),
    ));

    return Row(
      children: list,
    );
  }

  const CardRanking({Key? key, required this.abogado}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Card(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(
                                //placeholder
                                "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png")),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _starsForRatings(context),
                      Text(
                        abogado.nombre,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        abogado.descripcion,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ]))));
  }
}
