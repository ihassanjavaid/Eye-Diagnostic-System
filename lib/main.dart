import 'package:eye_diagnostic_system/app.dart';
import 'package:eye_diagnostic_system/init.dart';
import 'package:flutter/material.dart';

void main() async {
  // perform the necessary initializations
  await init();
  // Launch EyeSee
  runApp(EyeSee());
}

