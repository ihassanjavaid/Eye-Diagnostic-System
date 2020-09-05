import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class EyeFacts{

  static int _totalFacts = 20;

  Future<String>_loadFromAsset() async {
    return await rootBundle.loadString('assets/json/eye_facts.json');
  }

  Future<List<String>> _parseJson() async {
    String jsonString = await _loadFromAsset();
    return  jsonDecode(jsonString)['eye'] as List;
  }

 Future<String> getFact() async {
    int _randomNumber = Random().nextInt(_totalFacts);
    List _facts = await _parseJson();
    return _facts[_randomNumber];
  }

}