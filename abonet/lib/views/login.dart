import 'package:abonet/models/login_model.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  late LoginRequestModel requestModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 10),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Inicia Sesión",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => requestModel.email = input!,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'No puede estar vacio';
                            }
                            if (!text.contains("@")) {
                              return 'No ingreso un correo válido';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                              hintText: "Correo electrónico",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              prefixIcon: Icon(Icons.email,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) => requestModel.password = input!,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'No puede estar vacio';
                            }
                            if (text.length < 3) {
                              return 'Contraseña muy corta';
                            }
                            return null;
                          },
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                              hintText: "Contraseña",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.2)),
                              )),
                        ),
                        SizedBox(height: 20),
                        loginButton(context, "Iniciar como Abogado", true),
                        SizedBox(height: 10),
                        loginButton(context, "Iniciar como Cliente", false),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, route.registerView);
                          },
                          child: Text("Registrarse"),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              primary: Theme.of(context)
                                  .colorScheme
                                  .secondary, // background
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              minimumSize:
                                  const Size.fromHeight(50) // foreground
                              ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  ElevatedButton loginButton(
      BuildContext context, String text, bool isAbogado) {
    return ElevatedButton(
      onPressed: () async {
        if (validateAndSave()) {
          setState(() {
            isLoading = true;
          });

          //LoginService loginService =
          //    new LoginService();
          final authService = Provider.of<AuthService>(context, listen: false);
          if (isAbogado) {
            try {
              await authService.login(requestModel);
              Home.isAbogado = true;
              Navigator.of(context).pushReplacementNamed(route.homeView);
            } on Exception catch (_) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error de autenticacion'),
                  content: const Text('Correo o contraseña erroneo'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          } else {
            try {
              await authService.loginClient(requestModel);
              Home.isAbogado = false;
              Navigator.of(context).pushReplacementNamed(route.homeView);
            } on Exception catch (_) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error de autenticacion'),
                  content: const Text('Correo o contraseña erroneo'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          }
          setState(() => isLoading = false);
        }
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          primary: Theme.of(context).colorScheme.primary, // background
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          minimumSize: const Size.fromHeight(50) // foreground
          ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
