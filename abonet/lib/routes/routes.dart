import 'package:flutter/material.dart';

//views
import 'package:abonet/views/Chat.dart';
import 'package:abonet/views/home.dart';
import 'package:abonet/views/login.dart';

const String loginView = 'login';
const String homeView = 'home';
const String chatView = 'chat';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginView:
      return MaterialPageRoute(builder: (_) => Login(title: 'Login'));
    case homeView:
      return MaterialPageRoute(
          builder: (_) => Home(title: 'Flutter Demo Home Page'));
    case chatView:
      return MaterialPageRoute(
          builder: (_) => Chat(title: 'Flutter Demo Home Page'));
    default:
      throw ('Not defined route');
  }
}
