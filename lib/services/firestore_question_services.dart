import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eye_diagnostic_system/models/forum_question_data.dart';
import 'auth_service.dart';
import 'firestore_user_services.dart';

class FirestoreQuestionService{
  final _firestore = FirebaseFirestore.instance;
  FirestoreUserService _firestoreuserservice = FirestoreUserService();
  Auth _auth = Auth();


  Future<void> askQuestion({String question, String tag, int views =0, String uID})async{
    await checkInternConnection();

    DocumentReference documentReference =
    _firestore.collection('questions').doc();
    await documentReference.set({
      //'questionID': ,
      'question': question,
      'tag': tag,
      'views':views,
      'uID':uID
    });

    Future<List<Question>> getAllQuestions() async {
      List<Question> questions = [];

      await checkInternConnection();

      final currentUser = await _auth.getCurrentUser();
      // Fetch all questions
      final questionDocuments = await _firestore.collection('questions').get();

      // Get each user
      for (var ques in questionDocuments.docs) {
          Question question = Question(
              question: ques.data()['question'],
              tag: ques.data()['tag'],
              views: ques.data()['view'],
              uID: ques.data()['uID']
          );
          questions.add(question);
      }
      return questions;
    }
  }







}