import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/models/forum_question_data.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/utilities/global_methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import 'firestore_user_services.dart';

class FirestoreQuestionService{
  final _firestore = FirebaseFirestore.instance;
  FirestoreUserService _firestoreuserservice = FirestoreUserService();
  Auth _auth = Auth();


  Future<void> askQuestion({String question, String tag, int views =0, String email})async{
    await checkInternConnection();

    DocumentReference documentReference =
    _firestore.collection('questions').doc();
    await documentReference.set({
      //'questionID': ,
      'question': question,
      'tag': tag,
      'views':views,
      'email':email
    });
  }

  Future<List<Question>> getAllQuestions() async {
    List<Question> questions = [];

    await checkInternConnection();

    // Fetch all questions
    final questionDocuments = await _firestore.collection('questions').get();

    // Get each user
    for (var ques in questionDocuments.docs) {
      Question question = Question(
          question: ques.data()['question'],
          tag: ques.data()['tag'],
          views: ques.data()['view'],
          email: ques.data()['email']
      );
      questions.add(question);
    }
    return questions;
  }

  Future <List<Question>> getUserQuestions (String email) async {
    List<Question> questions = [];

    await checkInternConnection();

    final currentUser = await _auth.getCurrentUser();
    // Fetch all questions
    final questionDocuments = await _firestore.collection('questions').where('email', isEqualTo: email).get();

    // Get each user
    for (var ques in questionDocuments.docs) {
      Question question = Question(
          question: ques.data()['question'],
          tag: ques.data()['tag'],
          views: ques.data()['view'],
          email: ques.data()['uID']
      );
      questions.add(question);
    }
    return questions;
  }

  Future getAllPosts() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore.collection('questions').get();
    return qn.docs;
  }

  Future getTagPosts(context) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore
        .collection('questions')
        .where('tag', isEqualTo: Provider.of<ProviderData>(context).tagData)
        .get();
    return qn.docs;
  }

  Future getUserPosts() async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    QuerySnapshot qn = await _firestore.collection('questions').where('email', isEqualTo: _pref.getString('email')).get();
    return qn.docs;
  }

  Future<int> getTotalAnswers (String id) async{
    int count = 0;
    final answerDocuments = await _firestore.collection('answers').where('questionID', isEqualTo: id).get();
    List<DocumentSnapshot> total = answerDocuments.docs;
    count = total.length;
    return count;




  }






}