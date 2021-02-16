import 'dart:io';

import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/disease_result.dart';
import 'package:eye_diagnostic_system/services/server_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class ImagePickerScreen extends StatefulWidget {
  static const String id = 'image_picker_screen';

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File _image;
  ImagePicker _imagePicker;
  var pickedImage;


  _imgFromGallery() async {
    pickedImage = await _imagePicker.getImage(source: ImageSource.gallery,
        imageQuality: 100);

    setState(() {
      _image = File(pickedImage.path);
    });
  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      //_imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: HeaderCustomClipper(),
            child: Container(
              width: double.infinity,
              height: 160,
              color: kTealColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 10.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'EyeSee\t',
                          style: kDashboardTitleTextStyle.copyWith(color: kAmberColor),
                        ),
                        TextSpan(
                          text: 'Gallery',
                          style: kDashboardTitleTextStyle.copyWith(color: kAmberColor),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('jm').format(DateTime.now())}",
                        style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0)
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _image,
                    width: 200,
                    height: 400,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () async{
                Server server = Server();
                await server.diagnoseDisease(_image);
                // DiseaseResult diseaseResult = await server.diagnoseDisease(_image);
                // print(diseaseResult.isEye);
                // print(diseaseResult.result);
              },
              child: Text(
                'Upload'
              )
          )
        ],
      ),
    );
  }
}
