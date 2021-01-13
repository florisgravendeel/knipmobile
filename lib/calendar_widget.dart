import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'appointments.dart';
import 'appointments_widget.dart';
import 'calendar.dart';
import 'main.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {


  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();

  DateTime monday = Calendar.getMondayOfTheCurrentWeek();
  Appointments agenda;
  loadAppointments() async {
    agenda = await Appointments.create();
  }
  Widget appointmentsWidget = AppointmentsWidget(entries: [
    "Selecteer een datum", " om de tijden", " te weergeven."]);

  @override
  void initState() {
    super.initState();
    loadAppointments();
  }

  void resetCalendar(){
    _controller.animateToDate(monday);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kapper Knip'),
          centerTitle: true,
          backgroundColor: KnipApp.colorpallete[0],
          actions: [
            IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: resetCalendar),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.blueGrey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: DatePicker(
                  monday,
                  width: 60,
                  height: 80,
                  controller: _controller,
                  initialSelectedDate: Calendar.getFirstOpenDay(),
                  selectionColor: KnipApp.colorpallete[0],
                  selectedTextColor: Colors.white,
                  inactiveDates: [ // De dagen waarop de kapper gesloten is.
                    monday,
                    monday.add(Duration(days: 6)),
                    monday.add(Duration(days: 7)),
                    monday.add(Duration(days: 13))
                  ],
                  daysCount: 14, // Je kan hoogstens 1 week verder kijken.
                  locale: "nl_NL",
                  onDateChange: (date) {
                    // New date selected
                    appointmentsWidget = AppointmentsWidget(entries: agenda.getEntries(date));
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SizedBox(
                  child: appointmentsWidget,
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.6,
              ),
            ],
          ),
        ));
  }
}
