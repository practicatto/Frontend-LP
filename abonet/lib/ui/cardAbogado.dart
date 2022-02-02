import 'package:abonet/models/Abogado.dart';
import 'package:flutter/material.dart';

class cardAbogado extends StatelessWidget {
  final Abogado abogado;

  const cardAbogado({Key? key, required this.abogado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              dataAbogado(abogado: this.abogado),
            ],
          ),
        ),
      ),
    );
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
