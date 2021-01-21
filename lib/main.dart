import 'package:flutter/material.dart';
import 'home_widget.dart';

void main() => runApp(KnipApp());

class KnipApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knip App',
      home: Home(),
    );
  }
}
class ColorConfig {
  static Color primary = Color.fromRGBO(1, 22, 39, 1.0);
  static Color secondary = Colors.blueGrey[100];
  static Color white = Colors.blueGrey[50];
}