import 'dart:io';

import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/disease_result.dart';
import 'package:eye_diagnostic_system/services/server_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'package:eye_diagnostic_system/services/screen_arguments.dart';

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
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScreenArguments screenArgs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 50),
                child: Container(
                  width: size.width,
                  height: size.height / 2 - 60,
                  color: Color(0xffFDCF09),
                  child: _image != null
                      ? Image.file(
                        _image,
                        width: 200,
                        height: 400,
                        fit: BoxFit.fitHeight,
                      )
                      : Container(
                    decoration: BoxDecoration(
                        color: kGreyButtonColor,
                        ),
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Image Selected',
                        style: kLoginLabelStyle.copyWith(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //_showPicker(context);
                        _imgFromGallery();
                      },
                      child: Icon(
                        _image == null ?
                        Icons.add_a_photo : Icons.done_all,
                        color: _image == null ? kGreyButtonColor: kTealColor,
                        size: 42.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _image == null ?
                      'Select Image' : 'Image Selected',
                      style: _image == null ?
                      kDashboardButtonLabelStyle.copyWith(color: kGreyButtonColor) :
                      kDashboardButtonLabelStyle,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Server server = Server();
                        await server.diagnoseDisease(_image);
                      },
                      child: Icon(
                        Icons.send_rounded,
                        color: _image == null ? kGreyButtonColor: kTealColor,
                        size: 42.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Upload',
                      style: _image == null ?
                      kDashboardButtonLabelStyle.copyWith(color: kGreyButtonColor) :
                      kDashboardButtonLabelStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
