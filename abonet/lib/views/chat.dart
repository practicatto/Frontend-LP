import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;

class Chat extends StatefulWidget {
  Chat({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, route.loginView),
                  child: Text("login"))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
