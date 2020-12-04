import 'dart:async';

import 'package:businesbank/presentacion/login/login.dart';
import 'package:businesbank/presentacion/screens/start_slide.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pathImage = "assets/images/busine.png";

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 71, 204, 2),
        body: Center(
          child: Image.asset(
            pathImage,
            height: 300,
            width: 300,
          ),
        ),
      ),
    );

    // FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Busines',
      home: StartSlider(),
      routes: {
        IniciarSesion.routeName: (ctx) => IniciarSesion(),
        // SignupScreen.routeName: (ctx) => SignupScreen(),
      },
    );
  }
}
