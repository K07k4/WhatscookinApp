import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/Dificultad.dart';
import 'package:whatscookin/api/classes/Receta.dart';
import 'package:whatscookin/api/classes/TipoReceta.dart';

String path = api.baseUrl + "/receta";

Future<List> getAllRecetas() async {
  var response = await http.get(
      path + "/getAll"
  );
  List data = await json.decode(response.body);
  return data;
}


Future<Receta> getReceta(int idReceta) async {
  final response = await http.get(path + "/getReceta?idReceta=" + idReceta.toString());

  if(response.statusCode == 200) {
    var receta = Receta.fromJson(json.decode(response.body)[0]);

    return receta;
  } else {
    throw Exception('No se ha encontrado la receta');
  }
}

Future<List> getRecetasDeUsuario(int idUsuario) async {
  final response = await http.get(path + "/getRecetasBusqueda?idTipoReceta=&idUsuario=" + idUsuario.toString() + "&idDificultad=&duracion=&puntuacionMinima=&idIngrediente=" + idUsuario.toString());
  if(response.statusCode == 200) {

    List recetasBruto = json.decode(response.body);

    List recetas = [];
    for(int i = 0; i < recetasBruto.length; i++) {
      final receta = Receta.fromJson(recetasBruto[i]);
      recetas.add(receta);
    }

    return recetas;
  } else {
    throw Exception('No se han encontrado recetas');
  }
}

Future<Dificultad> getDificultad(int idDificultad) async {
  final response = await http.get(path + "/getDificultad?idDificultad=" + idDificultad.toString());

  if(response.statusCode == 200) {
    var dificultad = Dificultad.fromJson(json.decode(response.body)[0]);

    return dificultad;
  } else {
    throw Exception('No se ha encontrado la dificultad');
  }
}

Future<TipoReceta> getTipoReceta(int idTipoReceta) async {
  final response = await http.get(path + "/getTipoReceta?idTipoReceta=" + idTipoReceta.toString());

  if(response.statusCode == 200) {
    var tipoReceta = TipoReceta.fromJson(json.decode(response.body)[0]);

    return tipoReceta;
  } else {
    throw Exception('No se ha encontrado el tipo de receta');
  }
}
