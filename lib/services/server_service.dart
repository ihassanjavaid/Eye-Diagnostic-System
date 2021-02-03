import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Server {
  String url = 'http://10.0.2.2:5000/';

  Future getData(urlChanged) async {
    Response _response = await get(urlChanged);
    if (_response.statusCode == HttpStatus.ok)
      return _response.body;
    throw Exception('Error connecting to server!');
  }

  Future checkServerConnection() async {
    var data;
    try {
      data = await getData('${url}check_conn');
    }
    catch (err){
      throw err;
    }
    var decodedData = jsonDecode(data);
    print(decodedData['connection'].toString());
  }
}
