import 'package:abonet/models/Abogado.dart';
import 'package:abonet/services/api_service.dart';
import 'package:abonet/ui/LoadingView.dart';
import 'package:abonet/widgets/cardRanking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Ranking extends StatefulWidget {
  Ranking({Key? key, required this.title}) : super(key: key);
  final String title;

  List<Widget> generarRanking(List<Abogado> data) {
    List<Widget> rankingAbonet = [];
    data.asMap().forEach((index, element) {
      rankingAbonet.add(CardRanking(
        abogado: element,
        index: index,
      ));
    });
    return rankingAbonet;
  }

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
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Ranking',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.primary),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              ...widget.generarRanking(service.ranking),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
