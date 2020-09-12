class CustomDate {
  int year = 2019;
  int month = 1;
  int day = 1;

  /*CustomDate() {
    this.year = 2019;
    this.month = 1;
    this.day = 1;
  }*/

  @override
  String toString() {
    String dayStr;
    String monthStr;

    if (day < 10)
      dayStr = '0$day';
    else
      dayStr = '$day';

    if (month < 10)
      monthStr = '0$month';
    else
      monthStr = '$month';

    return '$dayStr/$monthStr/$year';
  }
}

class CustomTime {
  int hours = 0;
  int minutes = 0;

  /*CustomTime() {
    this.hours = 0;
    this.minutes = 0;
  }*/

  @override
  String toString() {
    String hourStr;
    String minStr;

    if (hours < 10)
      hourStr = '0$hours';
    else
      hourStr = '$hours';

    if (minutes < 10)
      minStr = '0$minutes';
    else
      minStr = '$minutes';

    return '$hourStr:$minStr';
  }
}
