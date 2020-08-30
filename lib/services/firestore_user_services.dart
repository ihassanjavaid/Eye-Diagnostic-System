import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eye_diagnostic_system/models/user_data.dart';

import 'auth_service.dart';

Future<void> checkInternConnection() async {
  final ConnectivityResult connectivityStatus =
  await (Connectivity().checkConnectivity());

  if (connectivityStatus == ConnectivityResult.none)
    throw 'No internet connection';
}

class FirestoreUserService {
  final _firestore = FirebaseFirestore.instance;
  Auth _auth = Auth();


  Future<void> registerUser({String displayName, String email,}) async {
    await checkInternConnection();

    DocumentReference documentReference =
    _firestore.collection('users').doc();
    await documentReference.set({
      'displayName': displayName,
      'email': email,
    });
  }

  Future<UserData> getUserData(String email) async {
    UserData userData;

    await checkInternConnection();

    final userDocuments = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (var userDocument in userDocuments.docs) {
      userData = UserData(
        email: userDocument.data()['email'],
        displayName: userDocument.data()['displayName'],
      );
    }

    return userData;
  }

  Future<List<UserData>> getAllUsers() async {
    List<UserData> users = [];

    await checkInternConnection();

    // Get current user
    final currentUser = await _auth.getCurrentUser();

    // Fetch all users
    final userDocuments = await _firestore.collection('users').getDocuments();

    // Get each user
    for (var user in userDocuments.documents) {
      if (user.data()['email'] != currentUser.email) {
        UserData userData = UserData(
            displayName: user.data()['displayName'],
            email: user.data()['email']);
        users.add(userData);
      }
    }
    return users;
  }
}
