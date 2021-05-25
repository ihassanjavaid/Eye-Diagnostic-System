import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/utilities/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_service.dart';

class FirestoreSymptomService {
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();
  User _user;

  Future<String> getCurrentUserEmail() async {
    _user = await _auth.getCurrentUser();
    return _user.email;
  }

  Future setSymptoms(List<bool> checks) async {
    await checkInternConnection();
    String _email = await getCurrentUserEmail();

    DocumentReference documentReference =
    _firestore.collection('symptoms').doc();

    try{
      await documentReference.set({
        'email': _email,
        'one': checks[0],
        'two' : checks[1],
        'three': checks[2],
        'four': checks[3],
        'five': checks[4],
        'six': checks[5],
        'seven': checks[6]
      });
    }
    catch (e) {
      throw Exception(e);
    }
  }

  Future getSymptoms() async {
    checkInternConnection();
    String _email = await getCurrentUserEmail();

    QuerySnapshot querySnapshot = await _firestore
        .collection('symptoms')
        .where('email', isEqualTo: _email)
        .get();

    return querySnapshot.docs.first;
  }
}

