import 'dart:convert';

import 'package:abonet/models/Categoria.dart';
import 'package:abonet/models/Ciudad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final _baseUrl = "10.0.2.2:8080/api/";
  final List<Categoria> categorias = [];
  final List<Ciudad> ciudades = [];
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  AuthService() {
    this.getCategorias();
    this.getCiudades();
  }

  Future<List<Ciudad>> getCiudades() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse("http://${_baseUrl}ubicacion/ciudades");
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      json
          .decode(resp.body)
          .forEach((item) => {ciudades.add(Ciudad.fromMap(item))});
    } else {
      throw Exception("Faild to get categorias");
    }

    this.isLoading = false;
    notifyListeners();

    return this.ciudades;
  }

  Future<List<Categoria>> getCategorias() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse("http://${_baseUrl}categorias/");
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      json
          .decode(resp.body)
          .forEach((item) => {categorias.add(Categoria.fromMap(item))});
    } else {
      throw Exception("Faild to get categorias");
    }

    this.isLoading = false;
    notifyListeners();

    return this.categorias;
  }

  Future<String?> createAbogado(String email, String password, String name,
      String? descripcion, String? experiencia) async {
    final url = Uri.parse("http://10.0.2.2:8080/api/abogados/register");

    final Map<String, dynamic> registerData = {
      "nombre_completo": name,
      "correo": email,
      "contrasena": password,
      "descripcion": descripcion,
      "experiencia": experiencia,
      "calificacion": 5,
    };
    print(json.encode(registerData));
    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(registerData));

    final Map<String, dynamic> data = json.decode(resp.body);

    print(data);
  }
}
