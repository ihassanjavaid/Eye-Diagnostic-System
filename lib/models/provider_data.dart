import 'package:flutter/cupertino.dart';

class ProviderData extends ChangeNotifier{
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

  //=== for assistant ===
  bool _isListeningValue = false;
  String _textValue = '';

  bool get isListeningValue => _isListeningValue;
  String get textValue => _textValue;

  void updateIsListeningValue(bool listen){
    this._isListeningValue = listen;
    notifyListeners();
  }

  void updateTextValue(String text){
    this._textValue = text;
    notifyListeners();
  }

}
