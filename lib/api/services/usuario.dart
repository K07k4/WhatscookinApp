import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/Usuario.dart';

String path = api.baseUrl + "/usuario";

Future<List> getAllUsuarios() async {
  var response = await http.get(path + "/getAll");
  List data = await json.decode(response.body);
  return data;
}

Future<Usuario> getUsuario(int idUsuario) async {
  final response =
      await http.get(path + "/getUsuario?idUsuario=" + idUsuario.toString());

  if (response.statusCode == 200) {
    var usuario = await Usuario.fromJson(json.decode(response.body));
    return usuario;
  } else {
    throw Exception('No se ha encontrado el usuario');
  }
}

Future<bool> recuperarPass(String email) async {
  var check = false;
  final response = await http.post(path + "/recuperarPass?email=" + email);

  if (response.statusCode == 200) {
    check = true;
  }

  return check;
}

Future<bool> crearUsuario(String nombre, String pass, String email) async {
  var check = false;
  final response = await http.post(
      path + "/add?nombre=" + nombre + "&pass=" + pass + "&email=" + email);

  if (response.statusCode == 200) {
    check = true;
  }
  return check;
}
