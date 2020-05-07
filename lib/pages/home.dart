import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatscookin/api/services/usuario.dart' as usuario;
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:whatscookin/pages/perfil.dart';

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
  final List<String> images = [
    "https://dummyimage.com/600x400/000/fff",
    "https://dummyimage.com/600x400/bd5ebd/fff",
    "https://dummyimage.com/600x400/665ebd/fff",
    "https://dummyimage.com/600x400/5ebda7/fff",
    "https://dummyimage.com/600x400/5ebd5e/fff",
    "https://dummyimage.com/600x400/a5bd5e/fff",
    "https://dummyimage.com/600x400/bd975e/fff",
  ];

  // TODO: Por algún motivo peta, intenta mostrar más items de los que hay
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
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
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: _buildItem,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "MEJOR PUNTUADAS",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 230,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          _buildItem(context, index, large: true),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Más cosas".toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 230,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          _buildItem(context, index, large: true),
                    ),
                  ),
                  SizedBox(height: 40.0),
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
                      onPressed: () {
                        print(busquedaController.text);
                      }, // TODO: Funcionalidad de búsqueda
                      child: Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                    ),
                    filled: true,
                    hintText: "Busca una receta",
                    hintStyle: TextStyle(color: Colors.black54)),
              ),
            )
          ],
        ));
  }

  Widget _buildItem(BuildContext context, index, {bool large = false}) {
    return GestureDetector(
      onTap: () {
        print(index);
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
                      images[index],
                    ),
                    fit: BoxFit.cover,
                  )),
              height: large ? 180 : 150,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Nombre de receta".toUpperCase(),
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
              SizedBox(height: 10,),
              Text(
                "Whatscookin",
                style: TextStyle(color: Colors.white, fontFamily: 'Alegra', fontSize: 40),
              ),
            ],
          ),
        ),
        OutlineButton(
          color: Colors.white,
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          child: Text("Búsqueda\nAvanzada".toUpperCase()),
          onPressed: () {}, // TODO: Funcionalidad de búsqueda con filtros
        ),
        SizedBox(width: 20.0),
      ],
    );
  }
}
