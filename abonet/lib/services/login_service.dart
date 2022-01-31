import 'package:abonet/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final Uri url = Uri.parse("http://10.0.2.2:8080/api/abogados/login");

    final response = await http.post(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(json.decode(response.body));
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al iniciar sesion");
    }
  }
}
