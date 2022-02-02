import 'package:abonet/providers/register_form_provider.dart';
import 'package:abonet/services/api_service.dart';
import 'package:abonet/services/auth_service.dart';
import 'package:abonet/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:abonet/routes/routes.dart' as route;
import 'package:provider/provider.dart';

import 'home.dart';

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
        body: ListView(
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
        child: ChangeNotifierProvider(
          create: (_) => RegisterFormProvider(),
          child: RegisterForm(),
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
    final apiService = Provider.of<ApiService>(context);

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
          SizedBox(height: 10),
          TextFormField(
              minLines: 1,
              maxLines: 3,
              onChanged: (value) => registerForm.direccion = value,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "Vivo en la Av...", labelText: "Dirección")),
          SizedBox(height: 20),
          CiudadesDropDown(),
          TextFormField(
              minLines: 1,
              maxLines: 3,
              onChanged: (value) => registerForm.telefono = value,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "0987456123", labelText: "Teléfono-Celular")),
          SizedBox(height: 20),
          CategCheckBox(
            apiService: apiService,
          ),
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

                    await authService
                        .createAbogado(
                            registerForm.email,
                            registerForm.password,
                            registerForm.name,
                            registerForm.descripcion,
                            registerForm.experiencia)
                        .then((value) async {
                      print(value);
                      CategCheckBox.createCatAbog(value!);
                      await apiService.postUbicacion(
                          CiudadesDropDown.ciudadElegida,
                          registerForm.direccion,
                          value);
                      await apiService.postTelefono(
                          registerForm.telefono, value);
                    });

                    Navigator.pushReplacementNamed(context, route.homeView);
                    while (Navigator.of(context).canPop())
                      Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Home(title: "Abonet"),
                        transitionDuration: Duration(seconds: 0)));
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

// ignore: must_be_immutable
class CategCheckBox extends StatefulWidget {
  var apiService;
  static List<String> categoriasEscogidas = [];
  CategCheckBox({Key? key, this.apiService}) : super(key: key);

  @override
  State<CategCheckBox> createState() =>
      _CategCheckBoxState(this.apiService, categoriasEscogidas);

  static void createCatAbog(String abogId) async {
    var apiService = ApiService();
    await apiService.postCategByAbog(categoriasEscogidas, abogId);
  }
}

class _CategCheckBoxState extends State<CategCheckBox> {
  List<String> categoriasSeleccionadas = [];
  var apiService;
  _CategCheckBoxState(this.apiService, this.categoriasSeleccionadas);

  void _onChanged(bool? isSelected, String categoria) {
    if (isSelected!) {
      setState(() {
        categoriasSeleccionadas.add(categoria);
      });
    } else {
      setState(() {
        categoriasSeleccionadas.remove(categoria);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String capitalize(String s) {
      return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
    }

    final _categorias = apiService.categorias;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Escoja las categorías:",
            style: TextStyle(fontSize: 16, color: Color(0xffa56d51))),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _categorias.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 35,
              child: Center(
                child: CheckboxListTile(
                  checkColor: Colors.white,
                  activeColor: Color(0xffeb9405),
                  value: categoriasSeleccionadas
                      .contains("${_categorias[index].id}"),
                  title: Text(capitalize("${_categorias[index].nombre}")),
                  onChanged: (bool? isSelected) {
                    _onChanged(isSelected, "${_categorias[index].id}");
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CiudadesDropDown extends StatefulWidget {
  CiudadesDropDown({Key? key}) : super(key: key);
  var ciudadesTotales = ApiService.ciudadesAll;
  static String ciudadElegida = ApiService.ciudadesAll[0];

  @override
  State<CiudadesDropDown> createState() => _CiudadesDropDownState();
}

class _CiudadesDropDownState extends State<CiudadesDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Escoja la ciudad donde vive:",
              style: TextStyle(fontSize: 16, color: Color(0xffa56d51))),
          DropdownButton<String>(
            value: CiudadesDropDown.ciudadElegida,
            items: widget.ciudadesTotales
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 18)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                CiudadesDropDown.ciudadElegida = newValue!;
              });
            },
            underline: Container(
              height: 2,
              color: Color(0xffeb9405),
            ),
          ),
        ],
      ),
    );
  }
}
