import 'package:abonet/models/Abogado.dart';
import 'package:abonet/widgets/abog_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardRanking extends StatelessWidget {
  final Abogado abogado;
  final int index;
  Widget _starsForRatings(context) {
    return Container(
        alignment: Alignment.centerRight,
        child: Row(children: [
          RatingBarIndicator(
            itemCount: 5,
            itemSize: 28,
            rating: this.abogado.calificacion,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(width: 5),
          Text(
            this.abogado.calificacion.toString(),
            style: Theme.of(context).textTheme.caption,
          ),
        ]));
  }

  const CardRanking({Key? key, required this.abogado, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => AbogInfo(abogado.id),
                  transitionDuration: Duration(seconds: 0)));
        },
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: Center(
                            child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary),
                      ),
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
                    ])))));
  }
}
