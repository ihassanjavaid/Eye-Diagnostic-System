import 'package:flutter/cupertino.dart';

class ProviderData extends ChangeNotifier{
  String _tagData ='';

  void updateTagData(String tag){
    this._tagData = tag;
    notifyListeners();
  }

  String get tagData => _tagData;
}
