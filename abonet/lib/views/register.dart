import 'package:abonet/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "Registro!",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  ButtonsColumn(),
                ])),
      ),
    );
  }
}

class ButtonsColumn extends StatelessWidget {
  const ButtonsColumn({Key? key}) : super(key: key);

  Function redirect(context, route) {
    return () {
      Navigator.pushNamed(context, route);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ButtonWidget(Color(0xff1c243c), "Registro de Abogado",
            () => Navigator.pushNamed(context, route.registerAbogView)),
        SizedBox(height: 10),
        ButtonWidget(Color(0xffeb9405), "Registro de cliente",
            () => Navigator.pushNamed(context, route.registerAbogView)),
        SizedBox(height: 10),
        TextButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, route.loginView),
          child: Text("¿Ya tienes una cuenta?"),
          style: TextButton.styleFrom(
              textStyle: TextStyle(color: Color(0xffa56d51))),
        ),
      ],
    );
  }
}
