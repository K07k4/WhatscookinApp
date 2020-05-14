import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatscookin/api/services/receta.dart' as apiReceta;
import 'package:whatscookin/pages/receta.dart';
import 'package:whatscookin/api/api.dart' as api;

import 'package:whatscookin/api/classes/Receta.dart' as RecetaClass;

import 'package:whatscookin/pages/perfil.dart';

import 'filtro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

final busquedaController = TextEditingController();

class _HomeState extends State<Home> {
  static final String path = "lib/src/pages/food/recipe_list.dart";
  final Color color1 = Color(0xffcc5214);
  final Color color2 = Color(0xffe8570e);
  final Color color3 = Color(0xffff5600);
  final Color color4 = Colors.deepOrange.shade300;

  List<dynamic> listNuevas = [];
  List<dynamic> listMejores = [];
  List<dynamic> listMasPuntuadas = [];

  List<Map> nuevas = [];
  List<Map> mejores = [];
  List<Map> masPuntuadas = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  mejoresRecetas() async {
    listMejores = await Future.value(apiReceta.getMejores());

    if (listMejores.length > 0) {
      mejores.clear();

      for (int i = 0; i < listMejores.length; i++) {
        var map = {};
        map['id'] = listMejores[i].idReceta;
        map['title'] = listMejores[i].titulo;
        map['image'] = api.baseUrl +
            "/imagen/get?id=" +
            listMejores[i].idReceta.toString() +
            "&tipo=receta";

        mejores.add(map);
      }
    }
  }

  nuevasRecetas() async {
    listNuevas = await Future.value(apiReceta.getMasRecientes());

    if (listNuevas.length > 0) {
      nuevas.clear();

      for (int i = 0; i < listNuevas.length; i++) {
        var map = {};
        map['id'] = listNuevas[i].idReceta;
        map['title'] = listNuevas[i].titulo;
        map['image'] = api.baseUrl +
            "/imagen/get?id=" +
            listNuevas[i].idReceta.toString() +
            "&tipo=receta";

        nuevas.add(map);
      }
    }
  }

  masPuntuadasRecetas() async {
    listMasPuntuadas = await Future.value(apiReceta.getMasPuntuadas());

    if (listMasPuntuadas.length > 0) {
      masPuntuadas.clear();

      for (int i = 0; i < listMasPuntuadas.length; i++) {
        var map = {};
        map['id'] = listMasPuntuadas[i].idReceta;
        map['title'] = listMasPuntuadas[i].titulo;
        map['image'] = api.baseUrl +
            "/imagen/get?id=" +
            listMasPuntuadas[i].idReceta.toString() +
            "&tipo=receta";

        masPuntuadas.add(map);
      }
    }
  }

  getData() async {
    setState(() {
      nuevasRecetas();
      mejoresRecetas();
      masPuntuadasRecetas();
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    Future.delayed(const Duration(seconds: 3),
        () => setState(() {}));
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        return Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                child: Icon(
                  Icons.person,
                  color: Colors.deepOrange,
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Perfil()),
                  );
                },
              ),
            ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      _buildHeader(context),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "NOVEDADES",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 210,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: nuevas.length,
                          itemBuilder: _buildItemTop,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "MEJOR PUNTUADAS",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 230,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: mejores.length,
                          itemBuilder: (context, index) =>
                              _buildItemMid(context, index, large: true),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "MÁS PUNTUADAS",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 230,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(left: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: masPuntuadas.length,
                          itemBuilder: (context, index) =>
                              _buildItemBot(context, index, large: true),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: Colors.orange[900]),
                              child: FlatButton(
                                child: Text(
                                  "¡Receta aleatoria!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                                onPressed: () async {
                                  int idAleatorio =
                                      await apiReceta.getAleatoria();
                                  Navigator.pushNamed(context, "/receta",
                                      arguments: idAleatorio);
                                },
                              ),
                            ),
                          )),
                      SizedBox(height: 80.0),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: TextField(
                    controller: busquedaController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Color(0xfff0f0f0),
                        suffixIcon: FlatButton(
                          onPressed: () async {
                            List<RecetaClass.Receta> listReceta =
                                await apiReceta.getRecetaBusquedaTitulo(
                                    busquedaController.text);

                            if (listReceta.length == 0) {
                              Fluttertoast.showToast(
                                  msg: "No existen recetas con esos parámetros",
                                  toastLength: Toast.LENGTH_LONG,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.deepOrange);
                            } else {
                              Navigator.pushNamed(context, "/busqueda",
                                  arguments: listReceta);
                            }
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                        ),
                        filled: true,
                        hintText: "Busca una receta",
                        hintStyle: TextStyle(color: Colors.black54)),
                  ),
                ),
              ],
            ));
      },
    );
  }

  Widget _buildItemTop(BuildContext context, index, {bool large = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Receta(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: nuevas[index]["id"],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: large ? 150 : 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      nuevas[index]['image'],
                    ),
                    fit: BoxFit.cover,
                  )),
              height: large ? 180 : 150,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                nuevas[index]['title'],
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemMid(BuildContext context, index, {bool large = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Receta(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: mejores[index]["id"],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: large ? 150 : 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      mejores[index]['image'],
                    ),
                    fit: BoxFit.cover,
                  )),
              height: large ? 180 : 150,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                mejores[index]['title'],
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemBot(BuildContext context, index, {bool large = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Receta(),
            // Pass the arguments as part of the RouteSettings. The
            // DetailScreen reads the arguments from these settings.
            settings: RouteSettings(
              arguments: masPuntuadas[index]["id"],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        width: large ? 150 : 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      masPuntuadas[index]['image'],
                    ),
                    fit: BoxFit.cover,
                  )),
              height: large ? 180 : 150,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                masPuntuadas[index]['title'],
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 40.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Whatscookin",
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Alegra', fontSize: 40),
              ),
            ],
          ),
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          child: Text("Búsqueda\nAvanzada".toUpperCase()),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Filtro()),
            );
          },
        ),
        SizedBox(width: 20.0),
      ],
    );
  }
}
