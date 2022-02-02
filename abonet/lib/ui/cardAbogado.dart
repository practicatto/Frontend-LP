import 'package:abonet/models/Abogado.dart';
import 'package:abonet/widgets/abog_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class cardAbogado extends StatelessWidget {
  final Abogado abogado;

  const cardAbogado({Key? key, required this.abogado}) : super(key: key);

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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              dataAbogado(abogado: this.abogado),
              estrellas(star: this.abogado.calificacion)
            ],
          ),
        ),
      ),
    );
  }
}

class estrellas extends StatelessWidget {
  final double star;
  const estrellas({
    required this.star,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      alignment: Alignment.centerRight,
      child: RatingBar.builder(
        itemCount: 5,
        itemSize: 28,
        allowHalfRating: true,
        initialRating: star,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.secondary,
        ),
        onRatingUpdate: (value) => null,
      ),
    ));
  }
}

class dataAbogado extends StatelessWidget {
  final Abogado abogado;
  const dataAbogado({Key? key, required this.abogado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            abogado.nombre,
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          ),
          Text(
            abogado.experiencia,
            style: TextStyle(fontStyle: FontStyle.italic),
          )
        ],
      ),
    );
  }
}
