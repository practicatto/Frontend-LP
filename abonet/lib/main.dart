import 'package:abonet/services/api_service.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'routes/routes.dart' as route;

void main() {
  runApp(MyApp());
}

Color mainColor = Color(0xff0A0E17);
Color acceColor = Color(0xFFeb9405);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
      ChangeNotifierProvider(create: (_) => ApiService())
    ], child: MyAppContent());
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
          headline6: TextStyle(fontSize: 28.0, fontFamily: 'Roboto'),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: acceColor, primary: mainColor, background: Colors.white),
      ),
      home: Home(title: 'Abonet'),
      onGenerateRoute: route.controller,
      initialRoute: route.checkingView,
    );
  }
}
