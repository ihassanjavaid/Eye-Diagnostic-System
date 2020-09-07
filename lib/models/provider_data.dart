import 'package:flutter/cupertino.dart';

class ProviderData extends ChangeNotifier{
  String tagData = '';

  void updateTagData(String tag){
    this.tagData = tag;
  }

  String getTagData(){
    return this.tagData;
  }
}
