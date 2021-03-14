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
    String accessToken = 'pk.eyJ1IjoiZXllc2VlZGlhZ25vc3RpY3MiLCJhIjoiY2ttNmZkN3pvMG5wczJvcHIzNXM0dXMydiJ9.OHEYuFFxLxK0fzFlqPU7WQ';
    String api = 'https://api.mapbox.com/geocoding/v5/mapbox.places/';
    String type = 'locality';
    String countryCode = 'PK';
    String url = '${api}${l2},${l1}.json?access_token=$accessToken&types=$type&reverseMode=distance&limit=1&country=$countryCode';
    String response;

      try {
        response = await _getData(url);
      }
      catch (err){
        debugPrint(err);
      }
      //var decodedData = jsonDecode(response);
      MyAddressData myAddressData = MyAddressData.fromJson(jsonDecode(response));

      if (myAddressData.features.isNotEmpty){
        return myAddressData.features.first.text;
      }
      return 'Unknown Place';
  }
}