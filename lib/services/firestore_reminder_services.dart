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
        // for showing the reminders in app in order 'last posted first'
        'timestamp': DateTime.now().millisecondsSinceEpoch
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
        // for showing the reminders in app in order 'last posted first'
        'timestamp': DateTime.now().millisecondsSinceEpoch
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
        .orderBy('timestamp', descending: true)
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
        .orderBy('timestamp', descending: true)
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

    return '${querySnapshot.docs.length}\ttotal reminders';
  }

  Future<void> deleteReminder(String title) async {
    QuerySnapshot _querySnapshot = await _firestore.collection('reminders')
        .where('title', isEqualTo: title)
        .get();
    DocumentReference _docRef = _querySnapshot.docs[0].reference;

    try{
      await _docRef.delete();
    } catch (e) {
      throw Exception(e);
    }
  }
  
}
