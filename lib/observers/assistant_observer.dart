import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssistantObserver extends ChangeNotifier{
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

}
