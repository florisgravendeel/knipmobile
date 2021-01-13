import 'package:flutter/material.dart';
import 'package:knipmobile/calendar_widget.dart';
import 'package:knipmobile/main.dart';
import 'package:knipmobile/treamentselect_widget.dart';
import 'package:knipmobile/whitebox_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TreatmentSelectWidget(),
    CalendarWidget(),
    WhiteboxWidget("Prijslijst!", KnipApp.colorpallete[4]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        selectedItemColor: KnipApp.colorpallete[2],
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: 'Prijslijst',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
