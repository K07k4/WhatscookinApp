import 'package:flutter/material.dart';
import 'package:whatscookin/api/classes/Dificultad.dart';
import 'package:whatscookin/api/classes/Receta.dart' as RecetaClass;
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/classes/TipoReceta.dart';
import 'package:whatscookin/api/services/receta.dart' as apiReceta;
import 'package:whatscookin/api/widgets/StarRating.dart';
import 'package:whatscookin/pages/receta.dart';

List<RecetaClass.Receta> listReceta = [];
List<Dificultad> listDificultad = [];
List<TipoReceta> listTipoReceta = [];

class Busqueda extends StatefulWidget {
  @override
  _BusquedaState createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listReceta = ModalRoute.of(context).settings.arguments;

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

// TODO: SOLUCION A LAS REQUESTS INFINITAS!!!:

class Lists extends StatelessWidget {
  final List<RecetaClass.Receta> _listRecetaBusqueda = listReceta;

  @override
  Widget build(BuildContext context) {

    getData() async {
      listDificultad = await apiReceta.getAllDificultades();
      listTipoReceta = await apiReceta.getAllTiposRecetas();
    }

    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done) {
        return ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: _listRecetaBusqueda.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            RecetaClass.Receta receta = _listRecetaBusqueda[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Receta(),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: receta.idReceta,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 110,
                      padding: EdgeInsets.only(
                          left: 0, top: 10, bottom: 70, right: 20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(api.baseUrl +
                                  "/imagen/get?id=" +
                                  receta.idReceta.toString() +
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  receta.titulo,
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
                            listTipoReceta[receta.idTipoReceta - 1].nombre,
                            style: TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            listDificultad[receta.idDificultad - 1]
                                .dificultad
                                .toString(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            receta.duracion.toString() + " min",
                            style: TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              StarRating(
                                color: Colors.deepOrange,
                                rating: receta.puntuacion/2,
                                borderColor: Colors.deepOrange,
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
      } else {
        return Scaffold(backgroundColor: Colors.transparent,);
      }
    });
  }
}
