import 'package:abonet/services/api_service.dart';
import 'package:abonet/ui/LoadingView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ranking extends StatefulWidget {
  Ranking({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ApiService>(context);
    if (service.isLoading) return LoadingView();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              Text(
                'Holaaa ${service.ranking}',
                style: TextStyle(fontSize: 48),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
