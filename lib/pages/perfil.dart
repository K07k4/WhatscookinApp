import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatscookin/api/classes/Usuario.dart';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/services/usuario.dart' as apiUsuario;
import 'package:whatscookin/api/services/receta.dart' as apiReceta;
import 'package:whatscookin/api/services/favorito.dart' as apiFavorito;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatscookin/pages/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'receta.dart';

int idUsuario;

int idRecetaBorrar;

List<dynamic> listMisRecetas = [];
List<dynamic> listFavoritos = [];
List<Map> misRecetas = [];

List<Map> misFavoritas = [];

//Dar funcionalidad para cambiar el correo?

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  Usuario usuario;


  String nombre = "";
  String email = "";
  var avatar =
      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png';



  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      infoUsuario();
      recetasUsuario();
      recetasFavoritas();
    });
  }

  infoUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUsuario = await prefs.getInt('idUsuario');

    if (idUsuario == null && idUsuario < 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
    usuario = await Future.value(apiUsuario.getUsuario(idUsuario));

    var tempAvatar = api.baseUrl +
        "/imagen/get?id=" +
        idUsuario.toString() +
        "&tipo=usuario";
    if (tempAvatar != null) {
      avatar = tempAvatar;
    }
    nombre = usuario.nombre;
    email = usuario.email;
  }

  recetasUsuario() async {
    listFavoritos =
        await Future.value(apiFavorito.getRecetasFavoritasDeUsuario(idUsuario));

    if (listFavoritos.length > 0) {
      misFavoritas.clear();

      for (int i = 0; i < listFavoritos.length; i++) {
        var map = {};
        map['id'] = listFavoritos[i].idReceta;
        map['title'] = listFavoritos[i].titulo;
        map['image'] = api.baseUrl +
            "/imagen/get?id=" +
            listFavoritos[i].idReceta.toString() +
            "&tipo=receta";

        misFavoritas.add(map);
      }
    }
  }

  recetasFavoritas() async {
    listMisRecetas =
        await Future.value(apiReceta.getRecetasDeUsuario(idUsuario));

    if (listMisRecetas.length > 0) {
      misRecetas.clear();

      for (int i = 0; i < listMisRecetas.length; i++) {
        var map = {};
        map['id'] = listMisRecetas[i].idReceta;
        map['title'] = listMisRecetas[i].titulo;
        map['image'] = api.baseUrl +
            "/imagen/get?id=" +
            listMisRecetas[i].idReceta.toString() +
            "&tipo=receta";

        misRecetas.add(map);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    Future.delayed(const Duration(milliseconds: 1200), () => setState(() {}));
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Navigator.pushNamed(context, "/crearReceta");
            },
          ),
          body: Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.orange,
                    Colors.deepOrange
                  ]),
                ),
              ),
              ListView.builder(
                itemCount: 5,
                itemBuilder: _mainListBuilder,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.04,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.width * 0.10,
                child: IconButton(
                  icon: Icon(Icons.exit_to_app, size: 40, color: Colors.white),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return LogOffDialog();
                        });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    if (index == 1) return _buildSectionHeader(context);
    if (index == 2) return _buildCollectionsRow();
    if (index == 3) return _buildFavoritesHeader(context);
    if (index == 4) return _buildListItem();
  }

  Container _buildListItem() {
    return Container(
      color: Colors.white,
      height: 290.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: misFavoritas.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Receta(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: misFavoritas[index]["id"],
                      ),
                    ),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            misFavoritas[index]['image'],
                          ),
                          fit: BoxFit.cover,
                        )),
                    margin:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    width: 200.0,
                    height: 120.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(misFavoritas[index]['title'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .merge(TextStyle(color: Colors.deepOrange.shade600))),
            ],
          );
        },
      ),
    );
  }

  Container _buildSectionHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Mis recetas",
                style: Theme.of(context).textTheme.title,
              ),
            ],
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }

  Container _buildCollectionsRow() {
    return Container(
      color: Colors.white,
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: misRecetas.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Receta(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: misRecetas[index]["id"],
                      ),
                    ),
                  );
                },
                onLongPress: () {
                  idRecetaBorrar = index;
                  showDialog(
                      context: context,
                      builder: (_) {
                        return DeleteReceta();
                      });
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            misRecetas[index]['image'],
                          ),
                          fit: BoxFit.cover,
                        )),
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    width: 200.0,
                    height: 120.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(misRecetas[index]['title'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .merge(TextStyle(color: Colors.deepOrange.shade600))),
            ],
          );
        },
      ),
    );
  }

  Container _buildFavoritesHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Mis favoritas",
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 190.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    nombre,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(email),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    height: 30.0,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(avatar),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LogOffDialog extends StatefulWidget {
  @override
  _LogOffDialogState createState() => new _LogOffDialogState();
}

class _LogOffDialogState extends State<LogOffDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text("¿Desea cerrar sesión?",
              style: TextStyle(fontSize: 17.0, color: Colors.deepOrange)),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Cerrar sesión",
                  style: TextStyle(fontSize: 17.0, color: Colors.deepOrange),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setInt('idUsuario', null);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                  Fluttertoast.showToast(
                      msg: "Sesión cerrada",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.deepOrangeAccent,
                      textColor: Colors.white);
                },
              ),
              FlatButton(
                child: Text(
                  "Cancelar",
                  style:
                      TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}


class DeleteReceta extends StatefulWidget {
  @override
  _DeleteRecetaState createState() => new _DeleteRecetaState();
}

class _DeleteRecetaState extends State<DeleteReceta> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text("¿Desea borrar la receta?",
              style: TextStyle(fontSize: 17.0, color: Colors.deepOrange)),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "Eliminar",
                  style: TextStyle(fontSize: 17.0, color: Colors.deepOrange),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  setState(() {
                    apiReceta.delete(misRecetas[idRecetaBorrar]["id"]); //FIXME: Borra pero no actualiza
                  });
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text(
                  "Cancelar",
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}