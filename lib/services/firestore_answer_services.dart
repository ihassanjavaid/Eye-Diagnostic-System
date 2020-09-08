import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eye_diagnostic_system/models/forum_question_data.dart';
import 'auth_service.dart';
import 'firestore_user_services.dart';

class FirestoreAnswerService{
  final _firestore = FirebaseFirestore.instance;
  FirestoreUserService _firestoreuserservice = FirestoreUserService();
  Auth _auth = Auth();

  Future<void> answerPost({String ans, String questionid, int likes =0, int dislikes = 0, String email, String name})async{
    await checkInternConnection();

    DocumentReference documentReference =
    _firestore.collection('answers').doc();
    await documentReference.set({
      'questionID': questionid,
      'answer': ans,
      'likes': likes,
      'dislikes': dislikes,
      'userEmail':email,
      'userName': name
    });
  }


}