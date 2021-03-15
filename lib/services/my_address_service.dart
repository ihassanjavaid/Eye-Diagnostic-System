import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:eye_diagnostic_system/models/my_address_data.dart';

class MyAddressService{
  final l1;
  final l2;

  MyAddressService({this.l1, this.l2});

  Future _getData(urlChanged) async {
    Response _response = await get(urlChanged);
    if (_response.statusCode == HttpStatus.ok)
      return _response.body;
    throw Exception('Error connecting to server!');
  }

  Future<String> getPlaceName() async {
    String accessToken = 'eecd2a1ac3336682bade121f181bd713';
    String api = 'http://api.positionstack.com/v1/reverse';
    String url = '$api?access_key=$accessToken&query=$l1,$l2';
    String response;

      try {
        response = await _getData(url);
      }
      catch (err){
        debugPrint(err.toString());
      }
      //var decodedData = jsonDecode(response);
      MyAddressData myAddressData = MyAddressData.fromJson(jsonDecode(response));

      if (myAddressData.data.isNotEmpty){
        return myAddressData.data.first.name;
      }
      return 'Unknown Place';
  }
}