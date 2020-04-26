import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/Ingrediente.dart';

String path = api.baseUrl + "/ingrediente";

Future<List> getIngredientesReceta(int idReceta) async {
  final response = await http.get(path + "/getIngredientesReceta?id=" + idReceta.toString());
  print(path + "/getIngredientesReceta?id="+idReceta.toString());
  if(response.statusCode == 200) {
    List ingredientesBruto = json.decode(response.body);

    List ingredientes = [];
    for(int i = 0; i < ingredientesBruto.length; i++) {
      final ingrediente = Ingrediente.fromJson(ingredientesBruto[i]);
      ingredientes.add(ingrediente);
    }
    return ingredientes;
  }
}