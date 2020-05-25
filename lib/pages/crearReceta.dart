import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatscookin/api/classes/TipoReceta.dart';
import 'package:whatscookin/api/classes/Ingrediente.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatscookin/pages/receta.dart';

import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/services/receta.dart' as apiReceta;
import 'package:whatscookin/api/services/ingrediente.dart' as apiIngrediente;
import 'package:whatscookin/api/services/imagenes.dart' as apiImagen;

class CrearReceta extends StatefulWidget {
  @override
  CrearRecetaPageState createState() => CrearRecetaPageState();
}

int idUsuario = 0;

List<int> listIdIngredientes = [];
List<dynamic> listTipos = [];

List<Map> mapIngredientes = [];
List<Map> mapTipos = [];

String tipoReceta = "";
var idTipoReceta = 0;
var duracion = 1.0;
var duracionStrMax = "120";

var dificultad = 1.0;
var dificultadStr = "Fácil";

final tituloController = TextEditingController();
final instruccionesController = TextEditingController();

class CrearRecetaPageState extends State<CrearReceta> {
  dynamic _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
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
                        "Crear receta",
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
                        child: Slider(
                            value: duracion,
                            min: 1,
                            max: 120,
                            divisions: 119,
                            activeColor: Colors.white,
                            label: "$duracion min",
                            onChanged: (double newValue) {
                              setState(() => duracion = newValue);
                            })),
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
                      child: Slider(
                          value: dificultad,
                          min: 1,
                          max: 3,
                          divisions: 2,
                          activeColor: Colors.white,
                          label: "$dificultadStr",
                          onChanged: (double newValue) {
                            setState(() {
                              dificultad = newValue;
                              switch (newValue.round()) {
                                case 1:
                                  dificultadStr = "Fácil";
                                  break;
                                case 2:
                                  dificultadStr = "Media";
                                  break;
                                case 3:
                                  dificultadStr = "Avanzada";
                                  break;
                              }
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        height: 200,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: instruccionesController,
                          onChanged: (String value) {},
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                              hintText: "Instrucciones",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 13)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
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
                            "Añadir imagen",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          onPressed: () async {
                            Fluttertoast.showToast(
                                msg: "Recomendamos una imagen apaisada",
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.deepOrangeAccent,
                                textColor: Colors.white);
                            _getImage();
                          },
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1.0)),
                      child: _image == null
                          ? Icon(
                              Icons.photo,
                              color: Colors.white,
                              size: 70.0,
                            )
                          : Image.file(_image)),
                  SizedBox(
                    height: 40,
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
                            "Crear receta",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            idUsuario = prefs.getInt('idUsuario');

                            if (tituloController.text.isNotEmpty &&
                                instruccionesController.text.isNotEmpty &&
                                idTipoReceta > 0 &&
                                listIdIngredientes.length > 0) {
                              print(listIdIngredientes.length);
                              if (_image != null) {
                                int idReceta = await apiReceta.crearReceta(
                                    tituloController.text,
                                    idUsuario,
                                    idTipoReceta,
                                    dificultad.round(),
                                    duracion.round(),
                                    instruccionesController.text,
                                    listIdIngredientes);

                                if (idReceta <= 0) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Comprueba que no hayas creado una receta con el mismo nombre",
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.deepOrangeAccent);
                                } else {
                                  apiImagen.uploadImagen(
                                      idReceta, "receta", _image);
                                  Navigator.of(context).popAndPushNamed('/home');
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Elige una imagen de la galería",
                                    toastLength: Toast.LENGTH_LONG,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.deepOrangeAccent);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Rellena todos los campos",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.deepOrangeAccent);
                            }
                          },
                        ),
                      )),
                  SizedBox(
                    height: 40,
                  ),
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
    List<Ingrediente> listIngredientes =
        await apiIngrediente.getAllIngredientes();
    // await Future.delayed(Duration(milliseconds: 400), null);
    List<dynamic> tagList = [];

    for (Ingrediente ingrediente in listIngredientes) {
      tagList.add({
        'name': ingrediente.ingrediente,
        'value': ingrediente.idIngrediente
      });
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
