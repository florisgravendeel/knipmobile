import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WhiteboxWidget extends StatelessWidget {

  final String title;
  final Color backgroundColor;

  WhiteboxWidget(this.title, this.backgroundColor) {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: backgroundColor,
        ));
  }
}
