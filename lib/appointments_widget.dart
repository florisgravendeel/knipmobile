import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knipmobile/calendar.dart';

import 'home_widget.dart';
import 'main.dart';

class AppointmentsWidget extends StatefulWidget {
  final List<String> entries;
  final List<int> entryColor = [];
  final setSelection;
  final getTime;

  AppointmentsWidget({Key key, this.entries, this.setSelection, this.getTime})
      : super(key: key);

  @override
  _AppointmentsWidgetState createState() => _AppointmentsWidgetState();
}

class _AppointmentsWidgetState extends State<AppointmentsWidget> {
  final List<String> entries2 = <String>[
    "9:00 - 9:30",
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
      body: Container(
          color: ColorConfig.secondary,
          child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: widget.entries.length,
              itemBuilder: (BuildContext context, int index) {
                String element = widget.entries[index];
                bool reserved = widget.entries[index] == 'Gereserveerd!';
                Color color;
                if (reserved) {
                  color = Color.fromRGBO(231, 29, 54, 1.0); // Reserved color
                } else if (widget.entryColor.contains(index)) {
                  color = Colors.green; // Selected color
                } else {
                  color = ColorConfig.primary; // Default color
                }
                return GestureDetector(
                  child: Container(
                      height: 40,
                      child: Center(
                          child: Text(element,
                              style: TextStyle(
                                  color: ColorConfig.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600))),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                        new BorderRadius.all(Radius.circular(10.0)),
                      )),
                  onTap: () {
                    if (reserved || element.contains("e")) {
                      return;
                    }
                    setState(() {
                      var x;
                      var a;
                      var y;
                      var b;
                      if (Home.of(context).reservation.is_one_hour) {
                        switch (widget.entryColor.length) {
                          case 0:
                            widget.entryColor.add(index);
                            break;
                          case 1:
                            if (widget.entryColor.contains(index)) {
                              widget.entryColor.remove(index);
                              break;
                            }
                            widget.entryColor.add(index);
                            a = widget.entryColor[0];
                            b = widget.entryColor[1];

                            x = entries2[a].split(" - ");
                            y = entries2[b].split(" - ");
                            widget.getTime(TimePeriod(x[0]), TimePeriod(y[1]));
                            break;
                          case 2:
                            if (widget.entryColor.contains(index)) {
                              widget.entryColor.remove(index);
                              break;
                            }
                            var first =
                                widget.entryColor.first; //remove first element
                            widget.entryColor.remove(first);
                            widget.entryColor.add(index);

                            a = widget.entryColor[0];
                            b = widget.entryColor[1];

                            x = entries2[a].split(" - ");
                            y = entries2[b].split(" - ");
                            widget.getTime(TimePeriod(x[0]), TimePeriod(y[1]));
                            break;
                        }
                      } else {
                        if (widget.entryColor.contains(index)) {
                          widget.entryColor.remove(index);
                          widget.setSelection(widget.entryColor.length, validAppointment());
                          return;
                        }
                        if (widget.entryColor.isNotEmpty) {
                          widget.entryColor.clear();
                        }
                        widget.entryColor.add(index);
                        x = entries2[index].split(" - ");

                        widget.getTime(TimePeriod(x[0]), TimePeriod(x[1]));
                        widget.setSelection(
                            widget.entryColor.length, validAppointment());
                        return;
                      }
                      widget.setSelection(
                          widget.entryColor.length, validAppointment());
                    });
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
              const Divider())),
    );
  }

  // checkt of 2 tijdvakken onder elkaar zijn geplaatst.
  bool validAppointment() {
    if (widget.entryColor.length == 2) {
      var x = widget.entryColor[0];
      var y = widget.entryColor[1];
      var total = (x - y);
      if (total == 1 || total == -1) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }
}
