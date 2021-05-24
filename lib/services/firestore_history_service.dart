import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/utilities/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'auth_service.dart';

class FirestoreHistoryService{
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();
  User _user;

  Future<String> getCurrentUserEmail() async {
    _user = await _auth.getCurrentUser();
    return _user.email;
  }

  Future<void> postResult(String text, String percentage) async {
    await checkInternConnection();
    String _email = await getCurrentUserEmail();

    DocumentReference documentReference =
    _firestore.collection('history').doc();

    try{
      await documentReference.set({
        'email': _email,
        'text': text,
        'percentage': percentage,
        'date': "${DateFormat('d-M-y').format(DateTime.now())}, ${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
        // for showing the reminders in app in order 'last posted first'
        'timestamp': DateTime.now().millisecondsSinceEpoch
      });
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future getHistory() async {
    checkInternConnection();
    String _email = await getCurrentUserEmail();

    QuerySnapshot querySnapshot = await _firestore
        .collection('history')
        .where('email', isEqualTo: _email)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs;
  }
}