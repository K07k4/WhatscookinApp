import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:whatscookin/api/api.dart' as api;
import 'dart:io';

String path = api.baseUrl + "/imagen";

Future<String> getImagen(String tipo, int id) async {
  final response =
      await http.get(path + "/get?id=" + id.toString() + "&tipo=" + tipo);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<String> uploadImagen(int id, String tipo, File file) async {
  var request = http.MultipartRequest('POST',
      Uri.parse(path + "/upload?id=" + id.toString() + "&tipo=" + tipo));

  print(file.path.split("/").last);

  request.files.add(http.MultipartFile(
      'file', file.readAsBytes().asStream(), file.lengthSync(),
      filename: file.path.split("/").last));
  var response = await request.send();
}
