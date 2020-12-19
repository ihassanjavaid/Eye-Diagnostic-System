import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReminderObserver extends ChangeNotifier{
  //=== for reminder ===
  DateTime _pickedDate = DateTime.now();
  TimeOfDay _pickedTime = TimeOfDay.fromDateTime(DateTime.now());
  String _reminderTitle = '';
  int _recurrence = 1;

  DateTime get pickedDate => _pickedDate;
  TimeOfDay get pickedTime => _pickedTime;
  String get reminderTitle => _reminderTitle;
  int get recurrence => _recurrence;

  void updatePickedTime(TimeOfDay time){
    this._pickedTime = time;
    notifyListeners();
  }

  void updatePickedDate(DateTime date){
    this._pickedDate = date;
    notifyListeners();
  }

  void updateReminderTitle(String title){
    this._reminderTitle = title;
    notifyListeners();
  }

  void updateRecurrence(int recur){
    this._recurrence = recur;
    notifyListeners();
  }
}
