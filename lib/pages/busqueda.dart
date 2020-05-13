import 'package:flutter/material.dart';
import 'package:whatscookin/api/classes/Receta.dart';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/widgets/StarRating.dart';

class Busqueda extends StatelessWidget {
  static final String path = "lib/src/pages/lists/list1.dart";

  static Receta recetaTest = Receta(
      2,
      2,
      "Primero coges la receta y le haces caso, sigues haciendo receta? Sigue asi muy bien la receta sale bien todos contentos comen comida y comida rica la comida rica gusta y tu gustas si la comida es rica buenos amigos todos feliz felicidad",
      "Dificil receta para hacer en la comodidad de  tu hogar caca pedo culo pipi",
      3,
      3,
      60,
      4.5,
      24);

  List<Receta> listReceta = [recetaTest];

  @override
  Widget build(BuildContext context) {

    if(listReceta.length == 0) {
      //TODO: Toast diciendo que no hay recetas
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepOrangeAccent, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            color: Colors.deepOrange,
          ),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Lists(),
        )),
      ),
    );
  }
}

Receta recetaTest = Receta(
    2,
    2,
    "Primero coges la receta y le haces caso, sigues haciendo receta? Sigue asi muy bien la receta sale bien todos contentos comen comida y comida rica la comida rica gusta y tu gustas si la comida es rica buenos amigos todos feliz felicidad",
    "Dificil receta para hacer en la comodidad de  tu hogar caca pedo culo pipi",
    3,
    3,
    60,
    4.5,
    24);

List<Receta> listReceta = [recetaTest];

class ItemBusqueda {
  final int id;
  final String titulo;
  final String tipo;
  final String dificultad;
  final int duracion;
  final double puntuacion;

  ItemBusqueda({
    this.id,
    this.titulo,
    this.tipo,
    this.dificultad,
    this.duracion,
    this.puntuacion,
  });
}

class Lists extends StatelessWidget {
  final List<ItemBusqueda> _listItemBusqueda = [
    ItemBusqueda(
        id: 1,
        titulo:
            'Dificil receta para hacer en la comodidad de  tu hogar caca pedo culo pipi',
        tipo: "Arroces",
        dificultad: "Fácil",
        duracion: 60,
        puntuacion: 5.0),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(6),
      itemCount: _listItemBusqueda.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        ItemBusqueda item = _listItemBusqueda[index];
        return GestureDetector(
          onTap: () {
            print(item.titulo);
            Navigator.pushNamed(context, "/receta", arguments: item.id);
          },
          child: Card(
            elevation: 3,
            child: Row(
              children: <Widget>[
                Container(
                  height: 200,
                  width: 110,
                  padding:
                      EdgeInsets.only(left: 0, top: 10, bottom: 70, right: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(api.baseUrl +
                              "/imagen/get?id=" +
                              item.id.toString() +
                              "&tipo=receta"),
                          fit: BoxFit.cover)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.titulo,
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.tipo,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.dificultad,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.duracion.toString() + " min",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          StarRating(
                            color: Colors.deepOrange,
                            rating: item.puntuacion,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
