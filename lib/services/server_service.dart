import 'dart:convert';

import 'package:http/http.dart';

class Server{
  String url = 'http://10.0.2.2:5000/';

  Future getData(urlChanged)async{
    Response _response = await get(urlChanged);
    return _response.body;
  }

  Future checkServerConnection()async{
    var data = await getData('${url}check_conn');
    print ('${url}check_conn');
    var decodedData = jsonDecode(data);
    print(decodedData['connection'].toString());
  }

}