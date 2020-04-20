import 'package:flutter/material.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

int idReceta = 1;
String nombreUsuario = "nombre";
String dificultad = "dificultad";
String tipoDeReceta = "tipo";
int duracion = 0;
String instrucciones = "instrucciones";

class Receta extends StatefulWidget {
  @override
  _RecetaState createState() => _RecetaState();
}

class _RecetaState extends State<Receta> {
  String image =
      "https://dummyimage.com/600x400/000/fff";
  String avatar =
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg";

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
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20.0),
                children: <Widget>[
                  Text(
                    "Revuelto de tortilla".toUpperCase(),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(avatar),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        nombreUsuario,
                        style: TextStyle(fontSize: 15.0),
                      ),
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
                            tipoDeReceta,
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
                      buildImage: "https://i.imgur.com/VSoUzGD.png",
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
