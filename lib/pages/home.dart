import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatscookin/api/services/usuario.dart' as usuario;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  String email = await usuario.getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Whatscookin',
          style: TextStyle(color: Colors.white,
          fontSize: 20.0,
          fontFamily: 'Alegra'),
        ),
        backgroundColor: Colors.red[600],
        centerTitle: true,
      ),
      backgroundColor: Colors.amberAccent,
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[Text("Recetas")],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
