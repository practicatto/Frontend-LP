import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/home.dart';
import 'package:abonet/views/login.dart';
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
          future: authService.readId(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text("Espere");
            }
            print(snapshot.data);
            if (snapshot.data == "") {
              Future.microtask(() {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Login(),
                        transitionDuration: Duration(seconds: 0)));
                //Navigator.of(context).pushReplacementNamed(route.loginView);
              });
            } else {
              Future.microtask(() {
                //Navigator.of(context).pushReplacementNamed(route.homeView);
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Home(
                              title: 'Abonet',
                            ),
                        transitionDuration: Duration(seconds: 0)));
              });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
