import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/components/pages.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/services/dialogflow_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AssistantVoice extends StatefulWidget {
  static const String id = 'assistant_voice_screen';

  @override
  _AssistantVoiceState createState() => _AssistantVoiceState();
}

class _AssistantVoiceState extends State<AssistantVoice> {
  DialogFlowService _dialogFlowService = DialogFlowService();
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Tap the mic and speak!';
  double _accuracy = 1.0;
  FlutterTts flutterTts;
  String finalText = '';
  String intentName;
  //TtsState ttsState;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    initTextToSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 200.0,
        width: 200.0,
        child: FittedBox(
          child: AvatarGlow(
            animate: Provider.of<ProviderData>(context).isListeningValue,
            // green color because purple background mixed with green gives golden color
            glowColor: kTealColor,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: () async {
                await _listen();
              },
              child: Icon(
                Provider.of<ProviderData>(context).isListeningValue
                    ? Icons.mic : Icons.mic_none,
              ),
              backgroundColor: kTealColor,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        /*decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: kBgColorGradientArrayBlues,
          ),
        ),*/
        color: kScaffoldBackgroundColor,
        child: Column(
          children: [
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
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                          TextSpan(
                            text: 'Assistant',
                            style: kDashboardTitleTextStyle.copyWith(
                                color: kAmberColor),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Accuracy: ${(_accuracy * 100.0).toStringAsFixed(1)}%',
                        style:
                            kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
              child: Text(
                Provider.of<ProviderData>(context).textValue,
                style: kDashboardTitleTextStyle.copyWith(
                    fontSize: 20.0, color: kTealColor.withOpacity(0.9)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _listen() async {
    intentName = '';

    if (!Provider.of<ProviderData>(context, listen: false).isListeningValue) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'notListening') {
            print('Last Sentence: ${_speech.lastRecognizedWords}');
            setState(() {
              _isListening = false;
            });
            Provider.of<ProviderData>(context, listen: false).updateIsListeningValue(false);
            // Business logic here for Assistant
            response(_speech.lastRecognizedWords);
            // Business logic ends here
          }
        },
        onError: (val) {
          print('onError: $val');
          Provider.of<ProviderData>(context, listen: false).updateTextValue('Tap the mic and speak!');
        },
      );

      if (available) {
        setState(() {
          _isListening = true;
        });
        Provider.of<ProviderData>(context, listen: false).updateIsListeningValue(true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            Provider.of<ProviderData>(context, listen: false).updateTextValue(_text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _accuracy = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() {
        return _isListening = false;
      });
      Provider.of<ProviderData>(context, listen: false).updateIsListeningValue(false);
      //_speech.stop();
    }
  }

  void response(query) async {

    if ( query == null || query == ''){
      query = 'ABC';
    }

    // Send query (voice message)
    AIResponse aiResponse =
        await _dialogFlowService.getResponseFromDialogFlow(query);

    intentName = '';
    // text response
    print(
        'Text response from google: ${aiResponse.getListMessage()[0]["text"]["text"][0].toString()}');
    // intent name response
    intentName = aiResponse.queryResult.intent.displayName;
    print('Intent name from google: $intentName');

    // navigate if command is to navigate to other screen
    if (intentName != null) {
      if (Pages.isAvailable(intentName)) {
        Navigator.pushNamed(context, intentName);
      }
    }
    /* else {*/
    await displayResponse(aiResponse);
    /* }*/
  }

  displayResponse(AIResponse aiResponse) async {
    String _texttoDisplay =
        aiResponse.getListMessage()[0]["text"]["text"][0].toString();
    setState(() {
      _text = _texttoDisplay;
    });
    Provider.of<ProviderData>(context, listen: false).updateTextValue(_texttoDisplay);
    //Provider.of<ProviderData>(context).textValue;
    await flutterTts.speak(_texttoDisplay);

    // _stop();
  }

  initTextToSpeech() async {
    if (Platform.isAndroid || Platform.isIOS) {
      flutterTts = FlutterTts();
      if (Platform.isIOS) {
        await flutterTts.setSharedInstance(true);
        await flutterTts
            .setIosAudioCategory(IosTextToSpeechAudioCategory.playAndRecord, [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ]);
      }

      // no need for special initializations and permissions on android
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(1.0);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
    }
  }
}
