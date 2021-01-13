import 'package:flutter/material.dart';
import 'home_widget.dart';

void main() => runApp(KnipApp());

class KnipApp extends StatelessWidget {

  static final List<Color> colorpallete = [
    Color.fromRGBO(1, 22, 39, 1.0),
    Color.fromRGBO(253, 255, 252, 1.0),
    Color.fromRGBO(46, 196, 182, 1.0),
    Color.fromRGBO(231, 29, 54, 1.0),
    Color.fromRGBO(255, 159, 28, 1.0),
    Color.fromRGBO(207, 216, 220, 1.0)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      home: Home(),
    );
  }
}