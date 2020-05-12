import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/Dificultad.dart';
import 'package:whatscookin/api/classes/Receta.dart';
import 'package:whatscookin/api/classes/TipoReceta.dart';

String path = api.baseUrl + "/receta";

Future<List> getAllRecetas() async {
  var response = await http.get(path + "/getAll");
  List data = await json.decode(response.body);
  return data;
}

Future<Receta> getReceta(int idReceta) async {
  final response =
      await http.get(path + "/getReceta?idReceta=" + idReceta.toString());

  if (response.statusCode == 200) {
    var receta = Receta.fromJson(json.decode(response.body)[0]);

    return receta;
  } else {
    getReceta(idReceta);
  }
}

Future<List> getRecetasDeUsuario(int idUsuario) async {
  final response = await http.get(path +
      "/getRecetasBusqueda?idTipoReceta=&idUsuario=" +
      idUsuario.toString() +
      "&idDificultad=&duracion=&puntuacionMinima=&idIngrediente=");
  if (response.statusCode == 200) {
    List recetasBruto = json.decode(response.body);

    List recetas = [];
    for (int i = 0; i < recetasBruto.length; i++) {
      final receta = Receta.fromJson(recetasBruto[i]);
      recetas.add(receta);
    }

    return recetas;
  } else {
    throw Exception('No se han encontrado recetas');
  }
}

Future<Dificultad> getDificultad(int idDificultad) async {
  final response = await http
      .get(path + "/getDificultad?idDificultad=" + idDificultad.toString());

  if (response.statusCode == 200) {
    var dificultad = Dificultad.fromJson(json.decode(response.body)[0]);

    return dificultad;
  } else {
    throw Exception('No se ha encontrado la dificultad');
  }
}

Future<TipoReceta> getTipoReceta(int idTipoReceta) async {
  final response = await http
      .get(path + "/getTipoReceta?idTipoReceta=" + idTipoReceta.toString());

  if (response.statusCode == 200) {
    var tipoReceta = TipoReceta.fromJson(json.decode(response.body)[0]);

    return tipoReceta;
  } else {
    throw Exception('No se ha encontrado el tipo de receta');
  }
}

puntuar(int idReceta, int idUsuario, double puntuacion) async {
  await http.post(path +
      "/puntuar?idReceta=" +
      idReceta.toString() +
      "&idUsuario=" +
      idUsuario.toString() +
      "&puntuacion=" +
      puntuacion.toString());
}

Future<List<Receta>> getRecetaBusqueda(
    String tituloReceta,
    int idTipoReceta,
    int dificultadMin,
    int dificultadMax,
    int duracionMin,
    int duracionMax,
    double puntuacionMin,
    double puntuacionMax,
    List<int> listaIdIngrediente) async {
  var request = path +
      "/getRecetasBusqueda?tituloReceta=" +
      tituloReceta +
      "&idTipoReceta=" +
      idTipoReceta.toString() +
      "&idUsuario=&idDificultadMin=" +
      dificultadMin.toString() +
      "&idDificultadMax=" +
      dificultadMax.toString() +
      "&duracionMin=" +
      duracionMin.toString() +
      "&duracionMax=" +
      duracionMax.toString() +
      "&puntuacionMin=" +
      (puntuacionMin * 2).toString() +
      "&puntuacionMax=" +
      (puntuacionMax * 2).toString();

  if (listaIdIngrediente != null) {
    for (int idIngrediente in listaIdIngrediente) {
      request += "&idIngrediente=" + idIngrediente.toString();
    }
  } else {
    request += "&idIngrediente=";
  }

  print(request);

  final response = await http.get(request);
  List<Receta> listRecetas = [];
  if (response.statusCode == 200) {
    try {
      int counter = 0;
      while (true) {
        listRecetas.add(Receta.fromJson(json.decode(response.body)[counter]));
        counter++;
      }
    } catch (e) {}

    for (Receta receta in listRecetas) {
      print(receta.titulo);
    }

    return listRecetas;
  }
}
