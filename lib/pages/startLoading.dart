import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home.dart';
import 'login.dart';

class StartLoading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<StartLoading> {
  @override
  void initState() {
    super.initState();
  }

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    int idUsuario = prefs.getInt('idUsuario');

    // Si ya está logeado, pasa a /home
    // TODO: Durante un momento se ve la pantalla de login
    if (idUsuario != null && idUsuario > 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }

    if (idUsuario == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }

    void navigationPageWel() {
      Navigator.of(context).pushReplacementNamed('/intro');
    }

    var _duration = new Duration(milliseconds: 1);

    // No la primera vez que se abre la app
    if (firstTime == null || firstTime) {
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationPageWel);
    }
  }

  @override
  Widget build(BuildContext context) {
    startTime();
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Center(
          child: SpinKitRipple(
        color: Colors.white,
        size: 300.0,
      )),
    );
  }
}
