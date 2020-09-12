import 'package:eye_diagnostic_system/models/date_time_data.dart';

class Reminder{
  String title;
  bool isRecurring;
  int recurrence;

  CustomTime actualTime;
  CustomDate actualDate;

  Reminder(){
    title = '';
    isRecurring = false;
    recurrence = 0;

    this.actualTime = CustomTime();
    this.actualDate = CustomDate();
  }


}