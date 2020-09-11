import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/models/reminder_data.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class FirestoreReminderService{
  final _firestore = FirebaseFirestore.instance;

  Future<void> postOneTimeReminder(Reminder reminder) async {
    
    await checkInternConnection();

    DocumentReference documentReference =
    _firestore.collection('reminders').doc();
    await documentReference.set({
      'email': reminder.email,
      'reminderDateTime': null,
      'title': reminder.title,
      'isRecurring': false,
    });
  }
}

extension DateTimeExtension on DateTime {
  DateTime applyTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}