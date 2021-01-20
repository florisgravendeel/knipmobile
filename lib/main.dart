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
      title: 'Knip App',
      home: Home(),
    );
  }
}
class ColorConfig {
  static final double _opacity = 1.0;
  static Color purple = Color.fromRGBO(63, 69, 116, 1.0);
  static Color darkPurple = Color.fromRGBO(146, 104, 194, 1.0);
  static Color lightPurple = Color.fromRGBO(152, 170, 223, 1.0);
  static Color blue = Color.fromRGBO(94, 120, 209, 1.0);
  static Color teal = Color.fromRGBO(92, 196, 220, 1.0);
  static Color creme = Color.fromRGBO(200, 216, 240, 1.0);
  static Color pink = Color.fromRGBO(209, 171, 229, 1.0);
  static Color orange = Color.fromRGBO(182, 155, 157, 1.0);
  static Color sand = Color.fromRGBO(225, 202, 196, 1.0);
}