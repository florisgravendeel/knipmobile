import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:knipmobile/reservation.dart';

class Appointments {
  final tuesday = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75];
  final wednesday = [1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66, 71, 76];
  final thursday = [2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67, 72, 77];
  final friday = [3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 53, 58, 63, 68, 73, 78];
  final saturday = [4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59, 64, 69, 74, 79];

  final timetable = ["9:00 -  9:30", "9:30 - 10:00", "10:00 - 10:30", "10:30 - 11:00", "11:00 - 11:30", "11:30 - 12:00",
                     "12:00 - 12:30", "12:30 - 13:00", "13:00 - 13:30", "13:30 - 14:00", "14:00 - 14:30", "14:30 - 15:00",
                     "15:00 - 15:30", "15:30 - 16:00", "16:00 - 16:30", "16:30 - 17:00"];

  var reservations;

  Appointments._create();

  static Future<Appointments> create() async {
    // Call the private constructor
    var component = Appointments._create();


    final response =
        await http.get(new Uri.http("10.0.2.2:5000", "/reserveringen"));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var json = jsonDecode(response.body);

      component.reservations = json['reserveringen'];
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
    // Do initialization that requires async
    //await component._complexAsyncInit();

    // Return the fully initialized object
    return component;
  }

  List<String> getEntries(DateTime date) {
    List<String> emptyList;
    int index = isFirstWeek(date) ? 0 : 1;
    switch (date.weekday) {
      case 2:
        return getAppointments(tuesday, reservations[index]);
      case 3:
        return getAppointments(wednesday, reservations[index]);
      case 4:
        return getAppointments(thursday, reservations[index]);
      case 5:
        return getAppointments(friday, reservations[index]);
      case 6:
        return getAppointments(saturday, reservations[index]);
      default:
        return emptyList;
    }
  }

  bool isFirstWeek(DateTime date) {
    DateTime date2 = DateTime.now();
    DateTime x = date.subtract(Duration(days: date.weekday));
    DateTime y = date2.subtract(Duration(days: date2.weekday));
    return (x.year - y.year == 0) &&
        (x.month - y.month == 0) &&
        (x.day - y.day == 0);
  }

  List<String> getAppointments(List<int> day, reservations) {
    var timetable = [
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
    var integers = [];
    for (var i = 0; i < reservations.length; i++) {
      if (day.contains(reservations[i])) {
        integers.add(reservations[i]);
      }
    }
    var integers_2 = [];
    for (var i = 0; i < day.length; i++) {
      if (integers.contains(day[i])) {
        integers_2.add(i);
      }
    }
    // timetable remove elements (highest to lowest ordered index)
    var integers_3 = integers_2.reversed.toList();
    for (var i = 0; i < integers_3.length; i++) {
      var index = integers_3[i];
      timetable[index] = "Gereserveerd!";
    }
    return timetable;
  }
}
