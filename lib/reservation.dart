import 'dart:convert';

import 'package:http/http.dart' as http;

class Reservation {
  String name;
  String email;
  String phonenumber;
  DateTime start_date;
  DateTime end_date;
  int kappers_id;
  String opmerking;
  String behandelings_id;
  bool is_one_hour = true;


  Future<bool> send() async {
    bool success = false;
    final response = await http.post(
      new Uri.http("10.0.2.2:5000", "/nieuweafspraak"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'naam': name,
        'email': email,
        'telefoon': phonenumber,
        'begin_datum': formatDateTimeToString(start_date),
        'eind_datum': formatDateTimeToString(end_date),
        'kapper_id': kappers_id.toString(),
        'behandelings_id': behandelings_id,
        'opmerking': opmerking
      }),
    ).timeout(Duration(seconds: 5),onTimeout: (){
      return;
    });
    if(response == null){
      return success;
    } else if (response.statusCode == 200){
      success = true;
    }
    return success;
  }
  String formatDateTimeToString(DateTime time) {
    String str = time.toString();
    String result = ""; // haalt de laatste 4 characters weg.
    if ((str != null) && (str.length > 0)) {
      result = str.substring(0, str.length - 4);
    }
    return result;
  }
}
