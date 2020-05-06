import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:whatscookin/api/services/usuario.dart' as apiUsuario;
import 'package:fluttertoast/fluttertoast.dart';

class Registro extends StatefulWidget {
  @override
  RegistroPageState createState() => RegistroPageState();
}

final usuarioController = TextEditingController();
final emailController = TextEditingController();
final passController = TextEditingController();
final passRepeatedController = TextEditingController();

limpiar() {
  usuarioController.clear();
  emailController.clear();
  passController.clear();
  passRepeatedController.clear();
}

bool isValid(String str, RegExp regExp) {
  return regExp.hasMatch(str);
}

RegExp emailRegExp = new RegExp(
    "^[a-zA-Z0-9_+&*-]+(?:\\." +
        "[a-zA-Z0-9_+&*-]+)*@" +
        "(?:[a-zA-Z0-9-]+\\.)+[a-z" +
        "A-Z]{2,7}\$",
    multiLine: false,
    caseSensitive: false);

RegExp nombreRegExp = new RegExp(
    "^[a-zA-ZÀ-ÿ\\u00f1\\u00d1]+(\\s*[a-zA-ZÀ-ÿ\\u00f1\\u00d1]*)*[a-zA-ZÀ-ÿ\\u00f1\\u00d1]+\$",
    multiLine: false,
    caseSensitive: false);

RegExp passRegExp =
    new RegExp("^((?!'|\\|=| |%).)*\$", multiLine: false, caseSensitive: false);

class RegistroPageState extends State<Registro> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x22873600), Color(0x226E2C00)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0x44BA4A00), Color(0x44CA6F1E)])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Whatscookin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontFamily: 'Alegra'),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange[600], Colors.orange[900]])),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.04,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, size: 40, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller: usuarioController,
                onChanged: (String value) {},
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                    hintText: "Usuario",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {},
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.email,
                        color: Colors.deepOrange,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller: passController,
                obscureText: true,
                onChanged: (String value) {},
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                    hintText: "Contraseña",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.deepOrange,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller: passRepeatedController,
                obscureText: true,
                onChanged: (String value) {},
                cursorColor: Colors.deepOrange,
                decoration: InputDecoration(
                    hintText: "Repita la contraseña",
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: Colors.deepOrange,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.orange[800]),
                child: FlatButton(
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  onPressed: () async {
                    var check = true;
                    final nombre = usuarioController.text;
                    final pass = passController.text;
                    final email = emailController.text;
                    final passRepeated = passRepeatedController.text;

                    if (pass != passRepeated) {
                      Fluttertoast.showToast(
                          msg: "La contraseña no coincide",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white);
                      check = false;
                    }

                    if (check && nombre.isEmpty ||
                        pass.isEmpty ||
                        email.isEmpty ||
                        passRepeated.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "No puede haber campos vacíos",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white);
                      check = false;
                    }
                    if ((!isValid(nombre, nombreRegExp) ||
                            nombre.length > 20) &&
                        check) {
                      Fluttertoast.showToast(
                          msg:
                              "El nombre no tiene un formato válido\nLa longitud debe ser entre 2-20 caracteres",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white);
                      check = false;
                    }

                    if (!isValid(email, emailRegExp) && check) {
                      Fluttertoast.showToast(
                          msg: "El email no tiene un formato válido",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white);
                      check = false;
                    }

                    if (!isValid(pass, passRegExp) && check) {
                      Fluttertoast.showToast(
                          msg:
                              "Algunos símbolos usados en la contraseña no son válidos",
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white);
                      check = false;
                    }

                    if (check) {
                      final registro =
                          await apiUsuario.crearUsuario(nombre, pass, email);

                      switch (registro) {
                        case 200:
                          Fluttertoast.showToast(
                              msg: "Usuario creado correctamente",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white);
                          Navigator.popAndPushNamed(context, "/login");
                          break;

                        case 403:
                          Fluttertoast.showToast(
                              msg:
                                  "El nombre o el email ya está/n registrado/s",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white);
                          break;
                        case 400:
                          Fluttertoast.showToast(
                              msg: "Ha ocurrido un error",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white);
                          break;
                        case 406:
                          Fluttertoast.showToast(
                              msg: "Algún o algunos campos son incorrectos",
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.deepOrangeAccent,
                              textColor: Colors.white);
                      }
                    }
                  },
                ),
              )),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
