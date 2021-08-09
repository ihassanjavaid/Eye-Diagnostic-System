import 'dart:io';

import 'package:eye_diagnostic_system/models/diagnosis_models/disease_result.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/fundus_result.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/infection_result.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/reporting_screen.dart';
import 'package:eye_diagnostic_system/models/diagnosis_models/disorder_result.dart';
import 'package:eye_diagnostic_system/services/server_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:firebase_ml_custom/firebase_ml_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

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

  /*Future<void> _diagnoseFundus() async {
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
  }*/

  Future<void> _diagnoseFundus() async {
    /*FirebaseCustomRemoteModel remoteModel =
      FirebaseCustomRemoteModel('Fundus-Detection');

    FirebaseModelDownloadConditions conditions =
    FirebaseModelDownloadConditions(
        androidRequireWifi: true,
        androidRequireDeviceIdle: true,
        androidRequireCharging: true,
        iosAllowCellularAccess: false,
        iosAllowBackgroundDownloading: true);

    FirebaseModelManager modelManager = FirebaseModelManager.instance;

    await modelManager.download(remoteModel, conditions);

    if (await modelManager.isModelDownloaded(remoteModel) == true) {
      // do something with this model

    } else {
      // fall back on a locally-bundled model or do something
      File modelFile = await modelManager.getLatestModelFile(remoteModel);
    }*/

    loadModel();

    getImageLabels();

  }

  /// Gets the model ready for inference on images.
  static Future<String> loadModel() async {
    final modelFile = await loadModelFromFirebase();
    return loadTFLiteModel(modelFile);
  }

  /// Downloads custom model from the Firebase console and return its file.
  /// located on the mobile device.
  static Future<File> loadModelFromFirebase() async {
    try {
      // Create model with a name that is specified in the Firebase console
      final model = FirebaseCustomRemoteModel('Fundus-Detection');

      // Specify conditions when the model can be downloaded.
      // If there is no wifi access when the app is started,
      // this app will continue loading until the conditions are satisfied.
      final conditions = FirebaseModelDownloadConditions(
          androidRequireWifi: true, iosAllowCellularAccess: false);

      // Create model manager associated with default Firebase App instance.
      final modelManager = FirebaseModelManager.instance;

      // Begin downloading and wait until the model is downloaded successfully.
      await modelManager.download(model, conditions);
      assert(await modelManager.isModelDownloaded(model) == true);

      // Get latest model file to use it for inference by the interpreter.
      var modelFile = await modelManager.getLatestModelFile(model);
      assert(modelFile != null);
      return modelFile;
    } catch (exception) {
      print('Failed on loading your model from Firebase: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }

  /// Loads the model into some TF Lite interpreter.
  /// In this case interpreter provided by tflite plugin.
  static Future<String> loadTFLiteModel(File modelFile) async {
    try {
      // TODO TFLite plugin is broken, see https://github.com/shaqian/flutter_tflite/issues/139#issuecomment-836596852
      final appDirectory = await getApplicationDocumentsDirectory();
      final labelsData =
          await rootBundle.load('assets/extras/fundus_detection_labels.txt');
      final labelsFile =
          await File('${appDirectory.path}/fundus_detection.txt')
              .writeAsBytes(labelsData.buffer.asUint8List(
                  labelsData.offsetInBytes, labelsData.lengthInBytes));
      assert(await Tflite.loadModel(
            model: modelFile.path,
            labels: labelsFile.path,
            isAsset: false,
          ) ==
          'success');
      return 'Model is loaded';
    } catch (exception) {
      print(
          'Failed on loading your model to the TFLite interpreter: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }

  Future<void> getImageLabels() async {
    File _image;
    List<Map<dynamic, dynamic>> _labels;
    try {
      final image = widget.image;
      if (image == null) {
        print('image is null');
        return;
      }
      // TODO TFLite plugin is broken, see https://github.com/shaqian/flutter_tflite/issues/139#issuecomment-836596852
      // Tflite.loadModel(model: model)
      var labels = List<Map>.from(await Tflite.runModelOnImage(
        path: image.path,
        //imageStd:,
      ));
      // var labels = List<Map>.from([]);
      setState(() {
        _labels = labels;
        _image = image;
      });
      print(_labels);
    } catch (exception) {
      print("Failed on getting your image and it's labels: $exception");
      print('Continuing with the program...');
      rethrow;
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

