import 'package:abonet/providers/register_form_provider.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:provider/provider.dart';

class RegistroAbogado extends StatelessWidget {
  const RegistroAbogado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            elevation: 10,
            backgroundColor: Color(0xff1c243c),
            title: Text('Registro Abogado',
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 30)),
          ),
        ),
        body: Column(
          children: [RegisterFields()],
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ChangeNotifierProvider(
              create: (_) => RegisterFormProvider(),
              child: RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
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
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: "Armando Paredes", labelText: "Nombre Completo"),
            onChanged: (value) => registerForm.name = value,
            validator: (value) => validateNotEmpty(value),
          ),
          SizedBox(height: 10),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "arm_par@gmail.com", labelText: "Email"),
              onChanged: (value) => registerForm.email = value,
              validator: (value) => validateEmail(value)),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            decoration: InputDecorations.authInputDecoration(
                hintText: "*****", labelText: "Contraseña"),
            onChanged: (value) => registerForm.password = value,
            validator: (value) => validateNotEmpty(value),
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: "Me dedico a...", labelText: "Descripcion"),
            onChanged: (value) => registerForm.descripcion = value,
          ),
          SizedBox(height: 10),
          TextFormField(
              minLines: 1,
              maxLines: 3,
              onChanged: (value) => registerForm.experiencia = value,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "Trabajo en...", labelText: "Experiencia")),
          SizedBox(height: 25),
          MaterialButton(
            minWidth: 250,
            height: 45,
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    if (!registerForm.isValidForm()) return;

                    registerForm.isLoading = true;

                    await authService.createAbogado(
                        registerForm.email,
                        registerForm.password,
                        registerForm.name,
                        registerForm.descripcion,
                        registerForm.experiencia);

                    Navigator.pushNamed(context, route.homeView);

                    registerForm.isLoading = false;
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
