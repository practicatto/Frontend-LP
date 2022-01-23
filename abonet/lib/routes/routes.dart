import 'package:flutter/material.dart';

//views
import 'package:abonet/views/Chat.dart';
import 'package:abonet/views/home.dart';
import 'package:abonet/views/Categorias.dart';
import 'package:abonet/views/login.dart';
import 'package:abonet/views/ciudades.dart';
import 'package:abonet/views/ranking.dart';
import 'package:abonet/views/register.dart';
import 'package:abonet/views/register_abogado.dart';

const String loginView = 'login';
const String homeView = 'home';
const String chatView = 'chat';
const String categoriasView = "Categorias";
const String rankingsView = "ranking";
const String ciudadesView = "ciudades";
const String registerView = 'register';
const String registerAbogView = 'registerAbog';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case rankingsView:
      return MaterialPageRoute(builder: (_) => Ranking(title: "Ranking"));
    case ciudadesView:
      return MaterialPageRoute(builder: (_) => Ciudades(title: "Ciudades"));
    case categoriasView:
      return MaterialPageRoute(
          builder: (_) => Categorias(title: "Catergorias"));
    case registerView:
      return MaterialPageRoute(builder: (_) => Register());
    case registerAbogView:
      return MaterialPageRoute(builder: (_) => RegistroAbogado());
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
