import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'firestore_user_services.dart';

class ForumQuestionService{
  final _firestore = FirebaseFirestore.instance;
  FirestoreUserService _firestoreuserservice = FirestoreUserService();


  Future<void> askQuestion({String question, String tag, int views =0, String userEmail, String userName})async{
    await checkInternConnection();

    DocumentReference documentReference =
    _firestore.collection('questions').doc();
    await documentReference.set({
      //'questionID': ,
      'question': question,
      'tag': tag,
      'views':views,
      'userEmail':userEmail,
      'userName':userName,
    });
  }







}