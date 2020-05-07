import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:whatscookin/pages/login.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => Login()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 36.0,  color: Colors.white, fontFamily: 'Alegra'),
      bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.white),
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.orangeAccent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Bienvenido/a a Whatscookin",
          body:
              "¿No sabes qué hacer de comer? No te preocupes, estás en el sitio adecuado",
          image: _buildImage('logo.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Encuentra y aprende recetas nuevas",
          body: "Encontrarás multitud de recetas de distintos tipos",
          image: _buildImage('cooking.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Guarda las que más te gusten",
          body: "¿Tiene buena pinta? Guárdala en favoritos para tenerla a mano",
          image: _buildImage('tasty.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Colabora con tus recetas",
          body:
              "Demuestra tus dotes culinarias y compártelas con los demás usuarios subiendo tus propias recetas",
          image: _buildImage('salt.gif'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "¡Disfruta de la app!",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          image: _buildImage('dance.gif'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Saltar', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      next: const Icon(Icons.arrow_forward, color: Colors.white,),
      done: const Text('Hecho', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
