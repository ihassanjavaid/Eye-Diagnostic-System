import 'package:eye_diagnostic_system/utilities/user_data.dart';

class Question{
  Question({this.question,this.tag,this.views, this.userName, this.userEmail});
  final String question;
  final String tag;
  int views;
  final String userEmail;
  final String userName;
}

