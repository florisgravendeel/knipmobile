import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'appointments.dart';
import 'appointments_widget.dart';
import 'calendar.dart';
import 'home_widget.dart';
import 'main.dart';

class CalendarWidget extends StatefulWidget {
  final function;
  CalendarWidget({Key key, this.function}) : super(key: key);

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

  final String title = 'Stap 3: kies een tijd.';

  @override
  void initState() {
    super.initState();
    loadAppointments();
  }

  void resetCalendar(){
    setState(() {
    _controller.animateToDate(monday);
    });
  }

  int count = -1;
  bool validAppointment = false;
  DateTime start_date;
  DateTime end_date;

  @override
  Widget build(BuildContext context) {
    var limit = Home.of(context).reservation.is_one_hour ? 2 : 1;
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 5.0,
          backgroundColor: ColorConfig.primary,
          actions: [
            IconButton(icon: Icon(Icons.refresh_sharp), onPressed: resetCalendar),
          ],
          title: Row(
            children: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.arrow_back_sharp),
                  onPressed: () {
                    setState(() {
                      Home.of(context).currentIndex = 1;
                    });
                  }),
              Text(title)
            ],
          ),
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
                  selectionColor: ColorConfig.primary,
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
                    appointmentsWidget = AppointmentsWidget(entries: agenda.getEntries(date), setSelection: setSelectionCount, getTime: getReservationInfo);
                    setState(() {
                      _selectedValue = date;
                      if(count == -1){count = 0;}
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
              Visibility(
                visible: !(count == -1),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 0),
                  child: Text(count.toString() + " van de " + limit.toString() + " tijdvakken \ngeselecteerd.", textAlign: TextAlign.center, style: TextStyle(decorationColor: Colors.blueGrey[100], fontWeight: FontWeight.w500, fontSize: 26),),
                ),
              )
            ],
          ),
        ), floatingActionButton: Visibility(
          visible: (count == limit) && validAppointment,
            child: FloatingActionButton(
              onPressed: () {
                Home.of(context).reservation.start_date = start_date;
                Home.of(context).reservation.end_date = end_date;
                Home.of(context).currentIndex = 3;
              },
              child: Icon(Icons.arrow_forward_rounded),
              backgroundColor: ColorConfig.primary,
      ),
    ),);
  }
  void setSelectionCount(int i, bool validAppointment){
    setState(() {
      count = i;
      this.validAppointment = validAppointment;
    });
  }
  void getReservationInfo(TimePeriod p1, TimePeriod p2){
    DateTime selectedDay = _selectedValue;
    setState(() {
      start_date = selectedDay.add(Duration(hours: p1.hours, minutes: p1.minutes));
        end_date = selectedDay.add(Duration(hours: p2.hours, minutes: p2.minutes));
    });
  }
}
