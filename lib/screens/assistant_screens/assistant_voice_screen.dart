import 'package:avatar_glow/avatar_glow.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/components/pages.dart';
import 'package:eye_diagnostic_system/services/dialogflow_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
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

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
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
            animate: _isListening,
            // green color because purple background mixed with green gives golden color
            glowColor: Colors.lightGreenAccent,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: FloatingActionButton(
              onPressed: _listen,
              child: Icon(
                  _isListening ?
                  Icons.mic :
                  Icons.mic_none,
              ),
              backgroundColor: kGoldenColor,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: kBgColorGradientArrayBlues,
          ),
        ),
        child: Column(
          children: [
            ClipPath(
              clipper: HeaderCustomClipper(),
              child: Container(
                width: double.infinity,
                height: 160,
                color: kPurpleColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, bottom: 10.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'EyeSee\t',
                            style: kDashboardTitleTextStyle.copyWith(color: kGoldenColor),
                          ),
                          TextSpan(
                            text: 'Assistant',
                            style: kDashboardTitleTextStyle.copyWith(color: kGoldenColor),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Accuracy: ${(_accuracy * 100.0).toStringAsFixed(1)}%',
                        style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
              child: Text(
                _text,
                style: kDashboardTitleTextStyle.copyWith(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          if ( val == 'notListening'){
            print('stopped listening...');
            print('Text going to google: $_text');
            // Dialogflow method here
            response(_text);
            val = '';
          }
          else {
            print('onStatus: $val');
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
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
      _speech.stop();
    }
  }

  void response(query) async {
    // Send query (voice message)
    AIResponse aiResponse = await _dialogFlowService.getResponseFromDialogFlow(query);

    String intentName = '';
    // text response
    print('Text response from google: ${aiResponse.getListMessage()[0]["text"]["text"][0].toString()}');
    // intent name response
    intentName = aiResponse.queryResult.intent.displayName;
    print('Intent name from google: $intentName');

    // navigate
    if (Pages.isAvailable(intentName)){
      Navigator.pushNamed(context, intentName);
    }

  }
}