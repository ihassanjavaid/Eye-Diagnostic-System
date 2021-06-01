import 'dart:io';

import 'package:eye_diagnostic_system/models/diagnosis_models/disease_result.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/fundus_result.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/infection_result.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/reporting_screen.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/disorder_result.dart';
import 'package:eye_diagnostic_system/services/server_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DiagnosisLoadingScreen extends StatefulWidget {

  final DiagnosisType diagnosisType;
  final File image;

  const DiagnosisLoadingScreen({Key key, @required this.diagnosisType, @required this.image})
      : super(key: key);

  @override
  _DiagnosisLoadingScreenState createState() => _DiagnosisLoadingScreenState();
}

class _DiagnosisLoadingScreenState extends State<DiagnosisLoadingScreen> {
  Server _server  = Server();

  @override
  void initState() {
    super.initState();

    if (widget.diagnosisType == DiagnosisType.DISEASE)
      _diagnoseDisease();
    else if (widget.diagnosisType == DiagnosisType.FUNDUS)
      _diagnoseFundus();
    else if (widget.diagnosisType == DiagnosisType.DISORDER)
      _diagnoseDisorder();
    else if(widget.diagnosisType == DiagnosisType.INFECTION)
      _diagnoseInfection();
  }

  Future<void> _diagnoseDisease() async {
    DiseaseResult result = await _server.diagnoseDisease(widget.image);

    if (result.isEye == 'false'){
      debugPrint('not eye!');
      AlertWidget().generateAlertInvalidDiagnosis(
          context: context,
          title: 'Invalid Image!',
          description: 'The image was not identified as an image of eye.',
          diagnosisType: DiagnosisType.DISEASE)
      .show();
      return;
    }
    else if (result.isClosed == 'true'){
      debugPrint('not eye!');
      AlertWidget().generateAlertInvalidDiagnosis(
          context: context,
          title: 'Closed-Eye Image!',
          description: 'Please upload an image with your eye open.',
          diagnosisType: DiagnosisType.DISEASE)
          .show();
      return;
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportingScreen(
                    text: result.result,
                    percentage: result.percentage,
                  )));
    }
  }

  Future<void> _diagnoseInfection() async {
    InfectionResult result = await _server.diagnoseInfection(widget.image);

    if (result.isEye == 'false'){
      debugPrint('not eye!');
      AlertWidget().generateAlertInvalidDiagnosis(
          context: context,
          title: 'Invalid Image!',
          description: 'The image was not identified as an image of eye.',
          diagnosisType: DiagnosisType.INFECTION)
          .show();
      return;
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportingScreen(
                text: result.result,
                percentage: result.percentage,
              )));
    }
  }

  Future<void> _diagnoseFundus() async {
    FundusResult result = await _server.diagnoseFundus(widget.image);

    if ( result.isFundus == 'false'){
      debugPrint('not fundus!');
      AlertWidget().generateAlertInvalidDiagnosis(
          context: context,
          title: 'Invalid Image!',
          description: 'The image was not identified as an image of a fundus.',
          diagnosisType: DiagnosisType.FUNDUS)
          .show();
      return;
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportingScreen(
                    text: result.result,
                    percentage: result.percentage,
                  )));
    }
  }

  Future<void> _diagnoseDisorder() async {
    DisorderResult result = await _server.diagnoseDisorder(widget.image);

    if ( !result.isEye ){
      debugPrint('can\'t predict!');
      AlertWidget().generateAlertInvalidDiagnosis(
          context: context,
          title: 'Can\'t predict!',
          description: 'The image couldn\'t be classified.',
          diagnosisType: DiagnosisType.DISORDER)
          .show();
      return;
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReportingScreen(
                text: result.result,
                percentage: result.percentage,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Center(
        child: SpinKitChasingDots(
          color: kTealColor,
          size: 80.0,
        ),
      ),
    );
  }
}

