import 'package:flutter/material.dart';
import 'package:whatscookin/pages/filtro.dart';
import 'package:whatscookin/pages/intro.dart';
import 'package:whatscookin/pages/login.dart';
import 'package:whatscookin/pages/olvidopass.dart';
import 'package:whatscookin/pages/perfil.dart';
import 'package:whatscookin/pages/receta.dart';
import 'package:whatscookin/pages/registro.dart';
import 'package:whatscookin/pages/startLoading.dart';

import 'pages/home.dart';

void main() => runApp(MaterialApp(initialRoute: '/filtro'
    '', routes: {
      '/home': (context) => Home(),
      '/receta': (context) => Receta(),
      '/login': (context) => Login(),
      '/registro': (context) => Registro(),
      '/perfil': (context) => Perfil(),
      '/olvidopass': (context) => OlvidoPass(),
      '/intro': (context) => Intro(),
      '/home': (context) => Home(),
      '/startLoading': (context) => StartLoading(),
       '/filtro': (context) => Filtro(),
    }));
