import 'dart:io';

import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService{
  FirebaseStorage storage = FirebaseStorage(storageBucket: "gs://eye-diagnostic-system-e87e7.appspot.com");
  Auth _auth = Auth();

  Future<String> uploadProfilePicture(File file) async {
    var user = await _auth.getCurrentUser();
    var userID = user.uid;

    var storageRef = storage.ref().child("user/profile/$userID");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;

    String downloadURL = await completedTask.ref.getDownloadURL();

    return downloadURL;
  }

  Future<String> getDownloadURL() async {
    var user = await _auth.getCurrentUser();
    var userID = user.uid;
    
    var storageRef = storage.ref().child("user/profile/$userID");
    return await storageRef.getDownloadURL();
  }
}