import 'dart:convert';
//import 'dart:html';
import 'dart:io';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
//import 'dart:async';

import 'package:eye_diagnostic_system/models/diagnosis_models/disease_result.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/fundus_result.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/disorder_result.dart';
//import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Server {
  String url = 'http://10.0.2.2:5000/';

  // Future getData(urlChanged) async {
  //   Response _response = await get(urlChanged);
  //   if (_response.statusCode == HttpStatus.ok)
  //     return _response.body;
  //   throw Exception('Error connecting to server!');
  // }

  // Future checkServerConnection() async {
  //   var data;
  //   try {
  //     data = await getData('${url}check_conn');
  //   }
  //   catch (err){
  //     throw err;
  //   }
  //   var decodedData = jsonDecode(data);
  //   print(decodedData['connection'].toString());
  // }

  Future diagnoseDisease(File image) async {
    var diseasesURL = '${url}diseases';

    String fileName = image.path.split('/').last;

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });

    Response<String> response = await Dio().post(diseasesURL, data: data);
    return DiseaseResult.fromJson(jsonDecode(response.data.toString()));
  }

  Future diagnoseFundus(File image) async {
    var fundusURL = '${url}fundus';

    String fileName = image.path.split('/').last;

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });

    Response<String> response = await Dio().post(fundusURL, data: data);
    return FundusResult.fromJson(jsonDecode(response.data.toString()));
  }

  Future diagnoseDisorder(File image) async {
    var disordersURL = '${url}disorders';

    String fileName = image.path.split('/').last;

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
    });

    Response<String> response = await Dio().post(disordersURL, data: data);
    return DisorderResult.fromJson(jsonDecode(response.data.toString()));
  }
}
