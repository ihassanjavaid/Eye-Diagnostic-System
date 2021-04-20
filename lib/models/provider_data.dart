import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  //=== for updating - setState((){}); ===
  String _modelString = '';

  String get modelString => _modelString;

  void updateModelString(String model){
    this._modelString = model;
    notifyListeners();
  }

  //=== for reminder ===
  DateTime _pickedDate = DateTime.now();
  TimeOfDay _pickedTime = TimeOfDay.fromDateTime(DateTime.now());
  String _reminderTitle = '';
  int _recurrence = 1;

  DateTime get pickedDate => _pickedDate;
  TimeOfDay get pickedTime => _pickedTime;
  String get reminderTitle => _reminderTitle;
  int get recurrence => _recurrence;

  void updatePickedTime(TimeOfDay time){
    this._pickedTime = time;
    notifyListeners();
  }

  void updatePickedDate(DateTime date){
    this._pickedDate = date;
    notifyListeners();
  }

  void updateReminderTitle(String title){
    this._reminderTitle = title;
    notifyListeners();
  }

  void updateRecurrence(int recur){
    this._recurrence = recur;
    notifyListeners();
  }

 //=== for duochrome ===
  int _rightMyopia = 0;
  int _leftMyopia = 0;
  int _rightHyperopia = 0;
  int _leftHyperopia = 0;

  int get rightMyopia => _rightMyopia;
  int get rightHyperopia => _rightHyperopia;
  int get leftMyopia => _leftMyopia;
  int get leftHyperopia => _leftHyperopia;

  void updateRightMyopia(){
    this._rightMyopia+=1;
    notifyListeners();
  }
  void updateLeftMyopia(){
    this._leftMyopia+=1;
    notifyListeners();
  }
  void updateRightHyperopia(){
    this._rightHyperopia+=1;
    notifyListeners();
  }
  void updateLeftHyperopia(){
    this._leftHyperopia+=1;
    notifyListeners();
  }

  //=== for astigmatism ===
  int _right = 0;
  int _left = 0;


  int get right => _right;
  int get left => _left;

  void updateRight(){
    this._right+=1;
    notifyListeners();
  }
  void updateLeft(){
    this._left+=1;
    notifyListeners();
  }

  //=== for Myopia ===
  double _rightMy = 0.0;
  double _leftMy = 0.0;

  double get rightMy => _rightMy;
  double get leftMy => _leftMy;

  void updateRightMy(double value){
    this._rightMy = value;
    notifyListeners();
  }

  void updateLeftMy(double value){
    this._leftMy = value;
    notifyListeners();
  }





}
