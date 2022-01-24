import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart' as route;

void main() {
  runApp(MyApp());
}

Color mainColor = Color(0xFF1c243c);
Color acceColor = Color(0xFFeb9405);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService())
      ],
      child: MyAppContent()
      );
  }
}

class MyAppContent extends StatelessWidget {
  const MyAppContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abonet',
      theme: ThemeData(
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: acceColor, primary: mainColor),
      ),
      home: Home(title: 'Abonet'),
      onGenerateRoute: route.controller,
      initialRoute: route.loginView,
    );
  }
}
