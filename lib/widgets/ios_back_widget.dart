import 'dart:io';

import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';

class BackWidgetiOS extends StatelessWidget {
  const BackWidgetiOS({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return Text('');
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kAmberColor,
            size: 28.0,
          ), onPressed: () {
          Navigator.pop(context);
        },
        ),
      ),
    );
  }
}