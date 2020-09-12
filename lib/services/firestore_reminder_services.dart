import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/models/reminder_data.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class FirestoreReminderService{
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();
  User _user;

  Future<String> getCurrentUserEmail() async {
    _user = await _auth.getCurrentUser();
    return _user.email;
  }

  Future<void> postOneTimeReminder(Reminder reminder) async {
    await checkInternConnection();
    String _email = await getCurrentUserEmail();

    DocumentReference documentReference =
    _firestore.collection('reminders').doc();

    try{
      await documentReference.set({
        'email': _email,
        'title': reminder.title,
        'actualTime': reminder.actualTime.toString(),
        'actualDate': reminder.actualDate.toString(),
        'isRecurring': reminder.isRecurring,
        'recurrence': 0,
      });
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future<void> postRecurringReminder(Reminder reminder) async {
    await checkInternConnection();
    String _email = await getCurrentUserEmail();

    DocumentReference documentReference =
    _firestore.collection('reminders').doc();

    try{
      await documentReference.set({
        'email': _email,
        'title': reminder.title,
        'actualDate': reminder.actualDate.toString(),
        'isRecurring': reminder.isRecurring,
        'recurrence': reminder.recurrence,
      });
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future getOneTimeReminders() async {
    checkInternConnection();
    String _email = await getCurrentUserEmail();

    QuerySnapshot querySnapshot = await _firestore
        .collection('reminders')
        .where('email', isEqualTo: _email)
        .where('isRecurring', isEqualTo: false)
        .get();
    
    return querySnapshot.docs;
  }

  Future getRecurringReminders() async {
    checkInternConnection();
    String _email = await getCurrentUserEmail();

    QuerySnapshot querySnapshot = await _firestore
        .collection('reminders')
        .where('email', isEqualTo: _email)
        .where('isRecurring', isEqualTo: true)
        .get();

    return querySnapshot.docs;
  }

  Future<String> getTotalRemindersCount() async {
    checkInternConnection();
    String _email = await getCurrentUserEmail();

    QuerySnapshot querySnapshot = await _firestore
        .collection('reminders')
        .where('email', isEqualTo: _email)
        .get();

    return '${querySnapshot.docs.length}\t total reminders';
  }
  
}
