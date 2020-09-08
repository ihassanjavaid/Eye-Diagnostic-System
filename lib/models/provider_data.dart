import 'package:flutter/cupertino.dart';

class ProviderData extends ChangeNotifier{
  String _tagData ='';
  String _questionData = '';
  String _questionID = '';

  void updateTagData(String tag){
    this._tagData = tag;
    notifyListeners();
  }

  String get tagData => _tagData;

  void updateQuestionData(String question){
    this._questionData = question;
    notifyListeners();
  }

  String get questionData => _questionData;

  void updateQuestionID(String id){
    this._questionID = id;
    notifyListeners();
  }
  String get questionID => _questionID;
}
