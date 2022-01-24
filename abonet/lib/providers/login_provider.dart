import 'package:abonet/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri url = "http://localhost:8080/api/login" as Uri;

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al iniciar sesion");
    }
  }
}
