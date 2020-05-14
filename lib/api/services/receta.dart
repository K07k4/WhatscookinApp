import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/Comentario.dart';
import 'package:whatscookin/api/classes/Dificultad.dart';
import 'package:whatscookin/api/classes/Ingrediente.dart';
import 'package:whatscookin/api/classes/Receta.dart';
import 'package:whatscookin/api/classes/TipoReceta.dart';

String path = api.baseUrl + "/receta";

Future<List> getAllRecetas() async {
  var response = await http.get(path + "/getAll");
  List data = await json.decode(response.body);
  return data;
}

Future<List> getAllTiposRecetas() async {
  var response = await http.get(path + "/getAllTipos");
  List data = await json.decode(response.body);

  List<TipoReceta> lista = [];

  for (int i = 0; i < data.length; i++) {
    lista.add(TipoReceta.fromJson(data[i]));
  }
  return lista;
}

Future<Receta> getReceta(int idReceta) async {
  final response =
      await http.get(path + "/getReceta?idReceta=" + idReceta.toString());

  if (response.statusCode == 200) {
    var receta = Receta.fromJson(json.decode(response.body)[0]);

    return receta;
  } else {
    throw Exception('No se ha encontrado receta');
  }
}

Future<int> getAleatoria() async {
  final response = await http.get(path + "/getAleatoria");

  if (response.statusCode == 200) {
    var idReceta = json.decode(response.body);

    return idReceta;
  } else {
    throw Exception('No se ha encontrado receta');
  }
}

Future<List> getMejores() async {
  var response = await http.get(path + "/getMejores");

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

Future<List> getMasPuntuadas() async {
  var response = await http.get(path + "/getMasPuntuadas");

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

Future<List> getMasRecientes() async {
  var response = await http.get(path + "/getMasRecientes");

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

Future<List> getRecetasDeUsuario(int idUsuario) async {
  final response = await http.get(path +
      "/getRecetasBusqueda?tituloReceta=&idTipoReceta=&idUsuario=" +
      idUsuario.toString() +
      "&idDificultadMin=&idDificultadMax=&duracionMin=&duracionMax=&puntuacionMin=&puntuacionMax=&idIngrediente");
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

Future<List> getAllDificultades() async {
  var response = await http.get(path + "/getAllDificultad");
  List data = await json.decode(response.body);

  List<Dificultad> dificultades = [];

  for (int i = 0; i < data.length; i++) {
    final dificultad = Dificultad.fromJson(data[i]);
    dificultades.add(dificultad);
  }

  return dificultades;
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

Future<List<Receta>> getRecetaBusquedaTitulo(String tituloReceta) async {
  var request = path +
      "/getRecetasBusqueda?tituloReceta=" +
      tituloReceta +
      "&idTipoReceta=&idUsuario=&idDificultadMin=&idDificultadMax=&duracionMin=&duracionMax=&puntuacionMin=&puntuacionMax=&idIngrediente=";
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

    return listRecetas;
  } else {
    throw Exception('No se ha encontrado el tipo de receta');
  }
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

    print(listRecetas);

    return listRecetas;
  } else {
    throw Exception('No se ha encontrado el tipo de receta');
  }
}

delete(int idReceta) async {
  await http.delete(path + "/delete?idReceta=" + idReceta.toString());
}

Future<int> crearReceta(
    String titulo,
    int idUsuario,
    int idTipoReceta,
    int idDificultad,
    int duracion,
    String instrucciones,
    List<int> listaIdIngredientes) async {
  var request = path +
      "/add?titulo=" +
      titulo +
      "&idUsuario=" +
      idUsuario.toString() +
      "&idTipoReceta=" +
      idTipoReceta.toString() +
      "&idDificultad=" +
      idDificultad.toString() +
      "&duracion=" +
      duracion.toString() +
      "&instrucciones=" +
      instrucciones;

  if (listaIdIngredientes != null) {
    for (int idIngrediente in listaIdIngredientes) {
      request += "&idIngrediente=" + idIngrediente.toString();
    }

    final response = await http.post(request);

    int idReceta;

    try {
      idReceta = int.parse(response.body);
    } catch (e) {
      return 0;
    }

    print("EL MEGA ID: " + idReceta.toString());

    return idReceta;
  } else {
    return 0;
  }
}


Future<List> getComentariosDeReceta(int idReceta) async {
  var response = await http.get(api.baseUrl + "/comentario/getComentariosEnReceta?id=" + idReceta.toString());

  if (response.statusCode == 200) {
    List comentariosBruto = json.decode(response.body);

    List comentarios = [];
    for (int i = 0; i < comentariosBruto.length; i++) {
      final comentario = Comentario.fromJson(comentariosBruto[i]);
      comentarios.add(comentario);
    }

    return comentarios;
  } else {
    throw Exception('No se han encontrado comentarios');
  }
}