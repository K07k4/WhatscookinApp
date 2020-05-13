import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

import 'package:whatscookin/api/services/receta.dart' as apiReceta;

class CrearReceta extends StatefulWidget {
  @override
  CrearRecetaPageState createState() => CrearRecetaPageState();
}

List<int> listIdIngredientes = [];
List<dynamic> listTipos = ["tipo", "tipo"];

List<Map> mapIngredientes = [];
List<Map> mapTipos = [];

String tipoReceta = "Tipo";
var duracionMin = 0.0;
var duracionMax = 120.0;
var duracionValues = RangeValues(duracionMin, duracionMax);
var duracionStrMax = "120";

var dificultadMin = 1.0;
var dificultadMax = 3.0;
var dificultadValues = RangeValues(dificultadMin, dificultadMax);
var dificultadStrMin = "Fácil";
var dificultadStrMax = "Avanzada";

var puntuacionMin = 0.0;
var puntuacionMax = 5.0;
var puntuacionValues = RangeValues(puntuacionMin, puntuacionMax);

final tituloController = TextEditingController();
final usuarioController = TextEditingController();

class CrearRecetaPageState extends State<CrearReceta> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    final Color color1 = Color(0xffcc5214);
    final Color color2 = Color(0xffe8570e);
    final Color color3 = Color(0xffff5600);
    final Color color4 = Colors.deepOrange.shade300;

    @override
    Widget loadingBuild(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
      );
    }

    return FutureBuilder(builder: (context, snapshot) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [color3, color4],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            ),
            Container(
              height: 450,
              width: 300,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(30)),
                  color: color2),
            ),
            Container(
              height: 100,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(30)),
                  color: color1),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Búsqueda avanzada",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      SizedBox(
                        width: 40,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        controller: tituloController,
                        onChanged: (String value) {},
                        cursorColor: Colors.deepOrange,
                        decoration: InputDecoration(
                            hintText: "Nombre de la receta",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 13)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                              color: Colors.orange[800]),
                          child: FlatButton(
                            child: Text(
                              "Tipo de receta",
                              style:
                              TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ListaTiposRecetaDialog();
                                  });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(tipoReceta,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontSize: 22)),
                      ),
                      SizedBox(
                        width: 35,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: FlutterTagging(
                          loadingBuilder: loadingBuild,
                          textFieldDecoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            hintText: "Ingredientes",
                          ),
                          chipsColor: Colors.deepOrangeAccent,
                          chipsFontColor: Colors.white,
                          deleteIcon: Icon(Icons.cancel, color: Colors.white),
                          chipsPadding: EdgeInsets.all(2.0),
                          chipsFontSize: 14.0,
                          chipsSpacing: 10.0,
                          suggestionsCallback: (pattern) async {
                            return await TagSearchService.getSuggestions(
                                pattern);
                          },
                          onChanged: (result) {
                            setState(() {
                              listIdIngredientes.clear();
                              var counter = 0;
                              try {
                                while (true) {
                                  listIdIngredientes
                                      .add((result[counter]['value']));

                                  print(listIdIngredientes.toString());

                                  counter++;
                                }
                              } catch (e) {
                                counter = 0;
                              }
                            });
                          },
                          addButtonWidget: null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Duración",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          valueIndicatorTextStyle: TextStyle(
                              color: Colors.deepOrangeAccent,
                              letterSpacing: 2.0)),
                      child: RangeSlider(
                        values: duracionValues,
                        min: 0,
                        max: 120,
                        divisions: 24,
                        activeColor: Colors.white,
                        labels: RangeLabels(
                            '${duracionValues.start.round()} min',
                            '$duracionStrMax min'),
                        onChanged: (values) {
                          setState(() {
                            if (values.end == 120.0) {
                              duracionStrMax = "∞";
                            } else {
                              duracionStrMax = values.end.toString();
                            }
                            duracionValues = values;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Dificultad",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          valueIndicatorTextStyle: TextStyle(
                              color: Colors.deepOrangeAccent,
                              letterSpacing: 2.0)),
                      child: RangeSlider(
                        // TODO: Debe obtener las dificultades desde la api
                        values: dificultadValues,
                        min: 1,
                        max: 3,
                        divisions: 2,
                        activeColor: Colors.white,
                        labels: RangeLabels(
                            '$dificultadStrMin', '$dificultadStrMax'),
                        onChanged: (values) {
                          setState(() {
                            switch (values.end.round()) {
                              case 1:
                                dificultadStrMax = "Fácil";
                                break;
                              case 2:
                                dificultadStrMax = "Media";
                                break;
                              case 3:
                                dificultadStrMax = "Avanzada";
                                break;
                            }
                            switch (values.start.round()) {
                              case 1:
                                dificultadStrMin = "Fácil";
                                break;
                              case 2:
                                dificultadStrMin = "Media";
                                break;
                              case 3:
                                dificultadStrMin = "Avanzada";
                                break;
                            }
                            dificultadValues = values;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Puntuación",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          valueIndicatorTextStyle: TextStyle(
                              color: Colors.deepOrangeAccent,
                              letterSpacing: 2.0)),
                      child: RangeSlider(
                        values: puntuacionValues,
                        min: 0,
                        max: 5,
                        divisions: 10,
                        activeColor: Colors.white,
                        labels: RangeLabels('${puntuacionValues.start}',
                            '${puntuacionValues.end}'),
                        onChanged: (values) {
                          setState(() {
                            puntuacionValues = values;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                            color: Colors.orange[900]),
                        child: FlatButton(
                          child: Text(
                            "Buscar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          onPressed: () async {
                            await apiReceta.getRecetaBusqueda(
                              //TODO: Falta tipo de receta
                                tituloController.text,
                                0,
                                dificultadValues.start.round(),
                                dificultadValues.end.round(),
                                duracionValues.start.round(),
                                duracionValues.end.round(),
                                puntuacionValues.start,
                                puntuacionValues.end,
                                listIdIngredientes);
                          },
                        ),
                      )),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.04,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

Widget setupAlertDialoadContainer() {
  return Container(
    height: 300.0,
    width: 300.0,
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile();
      },
    ),
  );
}

class ListaTiposRecetaDialog extends StatefulWidget {
  @override
  _ListaTiposRecetaDialogState createState() =>
      new _ListaTiposRecetaDialogState();
}

class _ListaTiposRecetaDialogState extends State<ListaTiposRecetaDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text("Tipos de receta",
              style: TextStyle(fontSize: 20.0, color: Colors.deepOrange)),
          SizedBox(
            height: 30,
          ),
          // TODO: Lista de tipos de ingredientes, de la api
        ],
      ),
    );
  }
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = <dynamic>[]; // TODO: Obtener todos los ingredientes
    tagList.add({'name': "Pollo", 'value': 1});
    tagList.add({'name': "Lechuga", 'value': 2});
    tagList.add({'name': "Aguacate", 'value': 3});
    tagList.add({'name': "Zanahoria", 'value': 4});
    tagList.add({'name': "Ternera", 'value': 5});
    List<dynamic> filteredTagList = <dynamic>[];
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}
