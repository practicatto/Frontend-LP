import 'package:abonet/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abonet/routes/routes.dart' as route;

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text("Espere");
            }
            print(snapshot.data);
            if (snapshot.data == "") {
              Future.microtask(() {
                Navigator.of(context).pushReplacementNamed(route.loginView);
              });
            } else {
              Future.microtask(() {
                Navigator.of(context).pushReplacementNamed(route.homeView);
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
