import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatscookin/api/api.dart' as api;
import 'package:whatscookin/api/services/usuario.dart' as apiUsuario;
import 'package:whatscookin/api/services/receta.dart' as apiReceta;
import 'package:whatscookin/api/widgets/StarRating.dart';

// TODO: Añadir posibilidad de puntuar
// TODO: Cargar si está o no en favoritos
// TODO: Añadir/eliminar de favoritos
// TODO: Dónde añadir los ingredientes?


int idReceta = 4; // TODO: Obtener el id de la receta de la vista anterior

int idUsuario;

int idDificultad;

int idTipoReceta;

String titulo = "";
String nombreUsuario = "";
String dificultad = "";
String tipoReceta = "";
int duracion = 0;
var puntuacion = 0.0;
String instrucciones = "";
bool recetaLoaded = false;
bool usuarioLoaded = false;

var favIcon = Icons.favorite_border;
var favColor = Colors.white;

class Receta extends StatefulWidget {
  @override
  _RecetaState createState() => _RecetaState();
}

class _RecetaState extends State<Receta> {
  var usuario;
  var receta;

  String image = "https://images2.imgbox.com/f6/7e/pXXtJViL_o.jpg";
  String avatar =
      "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    if (!recetaLoaded || !usuarioLoaded) {
      await infoReceta();
      await infoUsuario();
      print("Llamadas realizadas");
      setState(() {});
    }
  }

  infoReceta() async {
    if (recetaLoaded == false) {
      receta = await Future.value(apiReceta.getReceta(idReceta));
      idUsuario = receta.idUsuario;
      idDificultad = receta.idDificultad;
      idTipoReceta = receta.idTipoReceta;
      puntuacion = receta.puntuacion;

      titulo = receta.titulo;
      instrucciones = receta.instrucciones;
      duracion = receta.duracion;

      var tempImage = api.baseUrl +
          "/imagen/get?id=" +
          idReceta.toString() +
          "&tipo=receta";
      if (tempImage != null) {
        image = tempImage;
      }

      var itemDificultad =
          await Future.value(apiReceta.getDificultad(idDificultad));
      dificultad = itemDificultad.dificultad;

      var itemTipoReceta =
          await Future.value(apiReceta.getTipoReceta(idTipoReceta));
      tipoReceta = itemTipoReceta.nombre;
    }
    recetaLoaded = true;
  }

  infoUsuario() async {
    if (usuarioLoaded == false) {
      usuario = await Future.value(apiUsuario.getUsuario(idUsuario));

      var tempAvatar = api.baseUrl +
          "/imagen/get?id=" +
          idUsuario.toString() +
          "&tipo=usuario";
      if (tempAvatar != null) {
        avatar = tempAvatar;
      }
      nombreUsuario = usuario.nombre;
    }
    usuarioLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.deepOrangeAccent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width * 100,
                  height: 300.0,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProcess) {
                    if (loadingProcess == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.deepOrange),
                          value: loadingProcess.expectedTotalBytes != null
                              ? loadingProcess.cumulativeBytesLoaded /
                                  loadingProcess.expectedTotalBytes
                              : null),
                    );
                  },
                ),
                Positioned(
                  top: 10.0,
                  left: 4.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  top: 10.0,
                  left: 320.0,
                  child: IconButton(
                    icon: Icon(favIcon, size: 40, color: favColor),
                    onPressed: () {
                      if (favIcon == Icons.favorite_border) {
                        favIcon = Icons.favorite;
                        favColor = Colors.deepOrangeAccent;
                      } else {
                        favIcon = Icons.favorite_border;
                        favColor = Colors.white;
                      }
                      // TODO: Añadir funcionalidad de favorito
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.0),
                children: <Widget>[
                  Text(
                    titulo.toUpperCase(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          FlatButton(
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage(avatar),
                            ),
                            onPressed:
                                () {}, // TODO: Llevar al perfil del autor
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FlatButton(
                            child: Text(
                              nombreUsuario,
                              style: TextStyle(fontSize: 15.0),
                            ),
                            onPressed:
                                () {}, // TODO: Llevar al perfil del autor
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: StarRating(
                            rating: puntuacion,
                          ),
                          onPressed:
                              () {}, // TODO: Hacer algo para cambiar el voto. También debería salir la puntuación media con número
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.memory),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(dificultad)
                            ],
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Text(
                            tipoReceta,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.timer),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("$duracion min")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildStep(
                      buildImage:
                          "https://images2.imgbox.com/a6/75/zkZ5dCsY_o.png",
                      title: "CÓMO PREPARAR",
                      content: instrucciones),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({String buildImage, String title, String content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.deepOrange,
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Image.network(
              buildImage,
              height: 20,
            ),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              SizedBox(
                height: 15.0,
              ),
              Text(content),
            ],
          ),
        )
      ],
    );
  }
}
