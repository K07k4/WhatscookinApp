import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/Favorito.dart';
import 'package:whatscookin/api/classes/Receta.dart';

String path = api.baseUrl + "/favorito";

Future<List> getAllFavoritos() async {
  var response = await http.get(
      path + "/getAll"
  );
  List data = await json.decode(response.body);
  return data;
}


Future<Favorito> getFavorito(int idUsuario) async {
  final response = await http.get(path + "/getFavorito?idUsuario=" + idUsuario.toString());

  if(response.statusCode == 200) {
    var favorito = await Favorito.fromJson(json.decode(response.body));
    return favorito;
  } else {
    throw Exception('No se ha encontrado el favorito');
  }
}

Future<List> getRecetasFavoritasDeUsuario(int idUsuario) async {
  final response = await http.get(path + "/getRecetasFavoritasUsuario?idUsuario=" + idUsuario.toString());
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

setFavorito(int idUsuario, int idReceta) async {
  await http.post(path + "/add?idUsuario=" + idUsuario.toString() + "&idReceta=" + idReceta.toString());
}

deleteFavorito(int idUsuario, int idReceta) async {
  await http.delete(path + "/delete?idUsuario=" + idUsuario.toString() + "&idReceta=" + idReceta.toString());
}
