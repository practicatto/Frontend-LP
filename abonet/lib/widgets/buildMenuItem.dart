import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, String text) {
  Navigator.of(context).pop();
  switch (text) {
    case 'Home':
      Navigator.pushNamed(context, route.homeView);
      break;
    case 'Chat':
      Navigator.pushNamed(context, route.chatView);

      break;
    case 'Ranking':
      Navigator.pushNamed(context, route.rankingsView);
      break;

    default:
      Navigator.pushNamed(context, route.homeView);
  }
}
