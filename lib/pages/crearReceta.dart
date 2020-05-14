import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatscookin/api/classes/TipoReceta.dart';
import 'package:whatscookin/api/classes/Ingrediente.dart';
import 'package:whatscookin/api/classes/Receta.dart';


import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/services/receta.dart' as apiReceta;
import 'package:whatscookin/api/services/ingrediente.dart' as apiIngrediente;
import 'package:whatscookin/api/services/imagenes.dart' as apiImagen;

//TODO: Preparar la página para rellenar. Con adaptar un poco está hecho rápido


class CrearReceta extends StatefulWidget {
  @override
  CrearRecetaPageState createState() => CrearRecetaPageState();
}

List<int> listIdIngredientes = [];
List<dynamic> listTipos = [];

List<Map> mapIngredientes = [];
List<Map> mapTipos = [];

String tipoReceta = "Cualquiera";
var idTipoReceta = 0;
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

  dynamic _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('image: $_image');
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    listTipos = await apiReceta.getAllTiposRecetas();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    Future.delayed(const Duration(seconds: 1), () => setState(() {}));

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
                    height: 55,
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
                              setState(() {});
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
                            _getImage();
                          },
                        ),
                      )),
                  SizedBox(height: 50,),
                  Container(
                    child: _image == null ? Icon(Icons.photo) : Image.file(_image)
                  ),
                  SizedBox(height: 40,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100)),
                            color: Colors.orange[900]),
                        child: FlatButton(
                          child: Text(
                            "Enviar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          onPressed: () async {
                            apiImagen.uploadImagen(1, "receta", _image); // TODO: Hay que elegir el ID que se genera al crear la receta
                          },
                        ),
                      )),
                  SizedBox(height: 40,),
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
        return ListTile(title: Text("Hola"));
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
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w700)),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 450.0,
            width: 300.0,
            child: ListView.builder(
              padding: EdgeInsets.all(6),
              itemCount: listTipos.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                TipoReceta item = listTipos[index];
                return Column(
                  children: <Widget>[
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        color: Colors.white70,
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              tipoReceta = item.nombre;
                              idTipoReceta = item.idTipoReceta;
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            width: 250,
                            height: 105,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Image(
                                  image: NetworkImage(api.baseUrl +
                                      "/imagen/get?id=" +
                                      item.idTipoReceta.toString() +
                                      "&tipo=tipoReceta"),
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.nombre,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class TagSearchService {
  static Future<List> getSuggestions(String query) async {
    List<Ingrediente> listIngredientes = await apiIngrediente.getAllIngredientes();
    // await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = [];

    for(Ingrediente ingrediente in listIngredientes) {
      tagList.add({'name': ingrediente.ingrediente, 'value': ingrediente.idIngrediente});
    }
    List<dynamic> filteredTagList = <dynamic>[];
    for (var tag in tagList) {
      if (tag['name'].toLowerCase().contains(query)) {
        filteredTagList.add(tag);
      }
    }
    return filteredTagList;
  }
}
