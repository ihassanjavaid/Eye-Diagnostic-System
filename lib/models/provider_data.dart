import 'package:flutter/cupertino.dart';

class ProviderData extends ChangeNotifier{
  //=== for forums ===
  String _tagData ='';
  String _questionData = '';
  String _questionID = '';

  String get tagData => _tagData;
  String get questionData => _questionData;
  String get questionID => _questionID;

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

  //=== for assistant ===
}
