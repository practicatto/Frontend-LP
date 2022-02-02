import 'dart:convert';

import 'package:abonet/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final _baseUrl = "http://10.0.2.2:8080/api";

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password, String name) async {
    final url = Uri.parse("$_baseUrl/usuarios/");

    final Map<String, dynamic> body = {
      "correo": email,
      "contrasena": password,
      "nombre_completo": name,
    };
    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(body));

    final Map<String, dynamic> data = json.decode(resp.body);
    writeId(data, false);
  }

  Future<String?> createAbogado(String email, String password, String name,
      String? descripcion, String? experiencia) async {
    final url = Uri.parse("$_baseUrl/abogados/register");

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
    print(resp.body);
    final Map<String, dynamic> data = json.decode(resp.body);
    if (resp.statusCode != 500)
      return writeId(data, true);
    else
      throw Exception(data["message"]);
  }

  Future<String> login(LoginRequestModel requestModel) async {
    final Uri url = Uri.parse("$_baseUrl/abogados/login");
    print(requestModel.toJson());
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestModel.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {
      final Map<String, dynamic> data = json.decode(response.body);
      var returnData = writeId(data, true);
      print(returnData);
      return returnData;
    } else {
      throw Exception(response.body);
    }
  }

  Future<String> loginClient(LoginRequestModel requestModel) async {
    final Uri url = Uri.parse("$_baseUrl/usuarios/login");
    print(requestModel.toJson());
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestModel.toJson()));
    if (response.statusCode == 200 || response.statusCode == 400) {
      final Map<String, dynamic> data = json.decode(response.body);
      return writeId(data, false);
    } else {
      throw Exception(response.body);
    }
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }

  Future<String> readId() async {
    final token = await storage.read(key: "idUser") ?? "";
    return token;
  }

  Future<String> writeId(data, bool isAbogado) async {
    var returndata;
    if (data.containsKey("id")) {
      await storage.write(key: "idUser", value: "${data["id"]}");
      returndata = "${data["id"]}";
    } else {
      returndata = data["message"];
    }
    if (isAbogado) {
      await storage.write(key: "typeUser", value: "abogado");
    } else {
      await storage.write(key: "typeUser", value: "cliente");
    }
    return returndata;
  }
}
