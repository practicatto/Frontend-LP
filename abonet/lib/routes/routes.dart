import 'package:abonet/views/check_auth.dart';
import 'package:abonet/views/register_user.dart';
import 'package:flutter/material.dart';

//views
import 'package:abonet/views/chat.dart';
import 'package:abonet/views/home.dart';
import 'package:abonet/views/login.dart';
import 'package:abonet/views/ranking.dart';
import 'package:abonet/views/register.dart';
import 'package:abonet/views/register_abogado.dart';

const String loginView = 'login';
const String homeView = 'home';
const String chatView = 'chat';
const String rankingsView = "ranking";
const String registerView = 'register';
const String registerAbogView = 'registerAbog';
const String registerUserView = 'registerUser';
const String checkingView = 'checking';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case rankingsView:
      return MaterialPageRoute(builder: (_) => Ranking(title: "Ranking"));
    case registerView:
      return MaterialPageRoute(builder: (_) => Register());
    case registerAbogView:
      return MaterialPageRoute(builder: (_) => RegistroAbogado());
    case registerUserView:
      return MaterialPageRoute(builder: (_) => RegistroUsuario());
    case loginView:
      return MaterialPageRoute(builder: (_) => Login());
    case homeView:
      return MaterialPageRoute(builder: (_) => Home(title: 'Abonet'));
    case chatView:
      return MaterialPageRoute(builder: (_) => Chat(title: 'Chat'));
    case checkingView:
      return MaterialPageRoute(builder: (_) => CheckAuthScreen());
    default:
      throw ('Not defined route');
  }
}
