import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final _baseUrl = "http://10.0.2.2:8080/api/";

  final storage = new FlutterSecureStorage();

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
    final resp = await http.post(url, body: json.encode(registerData));

    final Map<String, dynamic> data = json.decode(resp.body);
    print(data);
    if (data.containsKey("id")) {
      await storage.write(key: "idUser", value: "${data["id"]}");
      return "${data["id"]}";
    } else {
      return data["message"];
    }
  }

  Future logout() async {
    await storage.deleteAll();
    return;
  }

  Future<String> readToken() async {
    final token = await storage.read(key: "idUser") ?? "";
    return token;
  }
}
