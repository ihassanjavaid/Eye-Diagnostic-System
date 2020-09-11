import 'package:flutter/material.dart';

class Reminder{
  String email;
  String title;
  bool isRecurring;
  int recurrence;
  DateTime uptilDate;
  DateTime actualDate;
  TimeOfDay actualTime;
}