import 'package:abonet/providers/register_form_provider.dart';
import 'package:abonet/services/api_service.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:provider/provider.dart';

import 'home.dart';

class RegistroUsuario extends StatelessWidget {
  const RegistroUsuario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Color(0xff1c243c),
            title: Text('Registro Cliente',
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 30)),
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [RegisterFields()],
          ),
        ));
  }
}

class RegisterFields extends StatelessWidget {
  const RegisterFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: ChangeNotifierProvider(
          create: (_) => RegisterFormProvider(),
          child: RegisterUserForm(),
        ),
      ),
    );
  }
}

class RegisterUserForm extends StatelessWidget {
  const RegisterUserForm({
    Key? key,
  }) : super(key: key);

  validateNotEmpty(value) {
    return (value ?? "").isEmpty ? 'Campo requerido' : null;
  }

  validateEmail(value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value ?? '')
        ? null
        : 'El valor ingresado no luce como un correo';
  }

  @override
  Widget build(BuildContext context) {
    final registerUserForm = Provider.of<RegisterFormProvider>(context);

    return Form(
      key: registerUserForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: "Armando Paredes", labelText: "Nombre Completo"),
            onChanged: (value) => registerUserForm.name = value,
            validator: (value) => validateNotEmpty(value),
          ),
          SizedBox(height: 15),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "arm_par@gmail.com", labelText: "Email"),
              onChanged: (value) => registerUserForm.email = value,
              validator: (value) => validateEmail(value)),
          SizedBox(height: 15),
          TextFormField(
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: "*****", labelText: "Contraseña"),
            onChanged: (value) => registerUserForm.password = value,
            validator: (value) => validateNotEmpty(value),
          ),
          SizedBox(height: 50),
          MaterialButton(
            minWidth: 250,
            height: 45,
            onPressed: registerUserForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (!registerUserForm.isValidForm()) return;

                    registerUserForm.isLoading = true;

                    try {
                      await authService.createUser(registerUserForm.email,
                          registerUserForm.password, registerUserForm.name);

                      Navigator.pushReplacementNamed(context, route.homeView);
                      while (Navigator.of(context).canPop())
                        Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Home(title: "Home"),
                          transitionDuration: Duration(seconds: 0)));
                      registerUserForm.isLoading = false;
                    } on Exception catch (e) {
                      registerUserForm.isLoading = false;
                      print(e);
                    }
                  },
            color: Color(0xff1c243c),
            disabledColor: Colors.grey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Text(
              "Regístrate",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
