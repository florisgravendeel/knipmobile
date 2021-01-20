import 'package:flutter/material.dart';
import 'package:knipmobile/barberselect_widget.dart';
import 'package:knipmobile/calendar_widget.dart';
import 'package:knipmobile/form_widget.dart';
import 'package:knipmobile/reservation.dart';
import 'package:knipmobile/treamentselect_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
  static _HomeState of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeState>();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  set currentIndex(int value) => setState(() => _currentIndex = value);
  final Reservation reservation = Reservation();

  final List<Widget> _children = [
    TreatmentSelectWidget(),
    BarberSelectWidget(),
    CalendarWidget(),
    FormWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

