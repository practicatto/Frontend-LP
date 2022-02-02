import 'dart:convert';

import 'package:abonet/models/Abogado.dart';
import 'package:abonet/models/Categoria.dart';
import 'package:abonet/models/Ciudad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService extends ChangeNotifier {
  final _baseUrl = "10.0.2.2:8080/api/";
  final List<Categoria> categorias = [];
  final List<Ciudad> ciudades = [];
  final List<Abogado> abogados = [];
  final List<Abogado> ranking = [];
  static List<String> ciudadesAll = [
    "Cuenca",
    "Duran",
    "Guayaquil",
    "Loja",
    "Quito",
    "Manta"
  ];
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  ApiService() {
    this.getCategorias();
    this.getAbogados();
    this.getCiudades();
    this.getRanking();
  }

  Future<List<Abogado>> getAbogadosCategoria(int id) async {
    final List<Abogado> aboInCategoria = [];
    final url = Uri.parse("http://${_baseUrl}abogados/by_categ?categoria=$id");
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      json
          .decode(resp.body)[0]
          .forEach((item) => {aboInCategoria.add(Abogado.fromMap(item))});
    } else {
      throw Exception("Faild to get Abogados");
    }
    return aboInCategoria;
  }

  Future<List<Abogado>> getAbogados() async {
    final url = Uri.parse("http://${_baseUrl}abogados/");
    this.isLoading = true;
    notifyListeners();

    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      json
          .decode(resp.body)
          .forEach((item) => {abogados.add(Abogado.fromMap(item))});
    } else {
      throw Exception("Faild to get Abogados");
    }

    this.isLoading = false;
    notifyListeners();
    return abogados;
  }

  Future<Map<String, dynamic>> getAbogadoById(abogId) async {
    final url = Uri.parse("http://${_baseUrl}abogados/by_id?id=$abogId");
    print(url);
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      return json.decode(resp.body);
    } else {
      throw Exception("Faild to get Abogado");
    }
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
      throw Exception("Faild to get ciudades");
    }

    this.isLoading = false;
    notifyListeners();

    return this.ciudades;
  }

  Future<List<Abogado>> getRanking() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.parse("http://${_baseUrl}abogados/ranking");
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      json
          .decode(resp.body)
          .forEach((item) => {ranking.add(Abogado.fromMap(item))});
    } else {
      throw Exception("Faild to get ranking");
    }
    this.isLoading = false;
    notifyListeners();
    return this.ranking;
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

  Future<List<Abogado>> getAbogadosCiudad(String nombre) async {
    final List<Abogado> aboInCiudad = [];
    final url = Uri.parse("http://${_baseUrl}abogados/byCiudad?ciudad=$nombre");
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      json
          .decode(resp.body)
          .forEach((item) => {aboInCiudad.add(Abogado.fromMap(item))});
    } else {
      throw Exception("Faild to get Abogados");
    }
    return aboInCiudad;
  }

  Future<void> postCategByAbog(List<String> categorias, String abogId) async {
    print(categorias);
    categorias.forEach((element) async {
      print(element);
      Map<String, dynamic> data = {
        "categoria": int.parse(element),
        "abogado": int.parse(abogId),
      };
      print(json.encode(data));
      final url = Uri.parse("http://${_baseUrl}abogadoscategoria");
      final resp = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(data));
      print(resp.body);
      if (resp.statusCode == 500) {
        throw Exception("Ocurrio un error al guardar la categoria del abogado");
      } else {
        print("Categoria guardada");
      }
    });
  }

  Future<void> postUbicacion(
      String ciudad, String direccion, String abogadoId) async {
    Map<String, dynamic> data = {
      "ciudad": ciudad,
      "direccion": direccion,
      "abogadoId": int.parse(abogadoId),
    };
    print(json.encode(data));
    final url = Uri.parse("http://${_baseUrl}ubicacion/");
    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    print(resp.body);
    if (resp.statusCode == 500) {
      throw Exception("Ocurrio un error al guardar la ubicacion del abogado");
    } else {
      print("Ubicacion guardada");
    }
  }

  Future<void> postTelefono(String telefono, String abogadoId) async {
    Map<String, dynamic> data = {
      "telefono": telefono,
      "abogadoId": int.parse(abogadoId),
    };
    print(json.encode(data));
    final url = Uri.parse("http://${_baseUrl}telefono/");
    final resp = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: json.encode(data));
    if (resp.statusCode == 500) {
      throw Exception("Ocurrio un error al guardar el telefono del abogado");
    } else {
      print(resp.body);
      print("Telefono guardado");
    }
  }
}
