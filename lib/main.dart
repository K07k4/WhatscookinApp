import 'package:flutter/material.dart';
import 'package:whatscookin/pages/intro.dart';
import 'package:whatscookin/pages/login.dart';
import 'package:whatscookin/pages/olvidopass.dart';
import 'package:whatscookin/pages/perfil.dart';
import 'package:whatscookin/pages/receta.dart';
import 'package:whatscookin/pages/registro.dart';

import 'pages/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/login', routes: {
      '/home': (context) => Home(),
      '/receta': (context) => Receta(),
      '/login': (context) => Login(),
      '/registro': (context) => Registro(),
      '/perfil': (context) => Perfil(),
      '/olvidopass': (context) => OlvidoPass(),
      '/intro': (context) => Intro(),
    }));
