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
  bool isLoading = true;
  final storage = new FlutterSecureStorage();

  ApiService() {
    this.getCategorias();
    this.getAbogados();
    this.getCiudades();
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
}
