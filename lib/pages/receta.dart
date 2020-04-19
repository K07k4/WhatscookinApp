import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class Receta extends StatefulWidget {
  @override
  RecetaPageState createState() => RecetaPageState();
}

class RecetaPageState extends State<Receta> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.deepOrangeAccent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(),
    );
  }
}


