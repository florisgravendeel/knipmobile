import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class AppointmentsWidget extends StatefulWidget {
  final List<String> entries;

  AppointmentsWidget({Key key, this.entries}) : super(key: key);

  @override
  _AppointmentsWidgetState createState() => _AppointmentsWidgetState();
}
class _AppointmentsWidgetState extends State<AppointmentsWidget> {

  final List<String> entries2 = <String>[
    "9:00 -  9:30",
    "9:30 - 10:00",
    "10:00 - 10:30",
    "10:30 - 11:00",
    "11:00 - 11:30",
    "11:30 - 12:00",
    "12:00 - 12:30",
    "12:30 - 13:00",
    "13:00 - 13:30",
    "13:30 - 14:00",
    "14:00 - 14:30",
    "14:30 - 15:00",
    "15:00 - 15:30",
    "15:30 - 16:00",
    "16:00 - 16:30",
    "16:30 - 17:00"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions() {
    return Container(
      color: KnipApp.colorpallete[5],
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: widget.entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 30,
            color: '${widget.entries[index]}' == 'Gereserveerd!' ? KnipApp.colorpallete[3] : KnipApp.colorpallete[0],
            child: Center(
                child: Text('${widget.entries[index]}',
                    style: TextStyle(
                        color: KnipApp.colorpallete[1], fontSize: 18))),
          );},
          separatorBuilder: (BuildContext context, int index) => const Divider())
    );
  }
}