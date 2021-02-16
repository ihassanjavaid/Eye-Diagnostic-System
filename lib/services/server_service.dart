import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'dart:async';

import 'package:eye_diagnostic_system/models/diagnosis_models/disease_result.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

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

  Future diagnoseDisease(File image) async {
    var diseasesURL = '${url}diseases';
    var bytes = image.readAsBytesSync();
    // var bytes = image.readAsStringSync();
    // var decodedbytes = base64.decode(bytes);
    var stream = ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse(diseasesURL);

    var request = MultipartRequest('POST', uri);
    var multipartFile = MultipartFile('file', stream, length, filename: basename(image.path));
    request.files.add(multipartFile);

    var response = await request.send();
    print(response.toString());
    response.stream.transform(utf8.decoder).listen((event) {
      print(event);}
      );


    // var response = await post(
    //     diseasesURL,
    //     //headers:{ "Content-Type":"form-data" } ,
    //     body: {"image":decodedbytes},
    //     encoding: Encoding.getByName("utf-8")
    // );
    // DiseaseResult diseaseResult =  DiseaseResult.fromJson(jsonDecode(response.stream.));
    // return diseaseResult;

  }
}


