import 'package:flutter/material.dart';

class Ranking extends StatefulWidget {
  Ranking({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Ranking',
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
