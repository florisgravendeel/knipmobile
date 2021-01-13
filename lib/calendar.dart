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