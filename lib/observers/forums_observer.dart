import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumsObserver extends ChangeNotifier{
  //=== for forums ===
  String _tagData ='';
  String _questionData = '';
  String _questionID = '';
  String _answerID = '';
  String get tagData => _tagData;
  String get questionData => _questionData;
  String get questionID => _questionID;
  String get answerID => _answerID;

  void updateTagData(String tag){
    this._tagData = tag;
    notifyListeners();
  }

  void updateQuestionData(String question){
    this._questionData = question;
    notifyListeners();
  }

  void updateQuestionID(String id){
    this._questionID = id;
    notifyListeners();
  }

  void updateAnswerID(String id){
    this._answerID = id;
    notifyListeners();
  }


}
