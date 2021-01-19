class Calendar {
  static DateTime getMondayOfTheCurrentWeek() {
    DateTime now = DateTime.now();
    int weekday = now.weekday;
    int duration = 0;
    switch (weekday){
      case 1:
        duration = 0;
        break;
      case 2:
        duration = -1;
        break;
      case 3:
        duration = -2;
        break;
      case 4:
        duration = -3;
        break;
      case 5:
        duration = -4;
        break;
      case 6:
        duration = -5;
        break;
      case 7:
        duration = -6;
        break;
      default:
        break;
    }
    return DateTime.now().add(Duration(days: duration));
  }

  static DateTime getFirstOpenDay() {
    DateTime now = DateTime.now();
    int weekday = now.weekday;
    int duration = 0;
    switch (weekday){
      case 1:
        duration = 1;
        break;
      case 2:
        duration = 0;
        break;
      case 3:
        duration = 0;
        break;
      case 4:
        duration = 0;
        break;
      case 5:
        duration = 0;
        break;
      case 6:
        duration = 0;
        break;
      case 7:
        duration = 2;
        break;
      default:
        break;
    }
    return now.add(Duration(days: duration));
  }
}
class TimePeriod {

  int minutes;
  int hours;

  TimePeriod(String time){
    var array = time.split(":");
    this.hours = int.parse(array[0]);
    if(array[1].substring(0,1).contains("0")){ // starts with 0
      this.minutes = int.parse(array[1].substring(1,2));
    } else {
      this.minutes = int.parse(array[1]);
    }
  }
}