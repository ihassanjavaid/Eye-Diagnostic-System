import 'package:avatar_glow/avatar_glow.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AssistantVoice extends StatefulWidget {
  static const String id = 'assistant_voice_screen';

  @override
  _AssistantVoiceState createState() => _AssistantVoiceState();
}

class _AssistantVoiceState extends State<AssistantVoice> {
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Welcome to Eye See!';
  double _confidence = 1.0;

  final Map<String, HighlightedWord> _highlights = {
    'eye' :HighlightedWord(
      onTap: () {},
      textStyle: kDashboardTitleTextStyle.copyWith(color: kGoldenColor)
    ),
    'see' : HighlightedWord(
        onTap: () {},
        textStyle: kDashboardTitleTextStyle.copyWith(color: kGoldenColor)
    )
  };

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accuracy: ${(_confidence*100.0).toStringAsFixed(1)}%',
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: kBgColorGradientArrayBlues,
          ),
        ),
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 150.0),
            child: TextHighlight(
              text: _text,
              words: _highlights,
              textStyle: kDashboardTitleTextStyle
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: _isListening,
        // green color because purple background mixed with green gives golden color
        glowColor: Colors.lightGreenAccent,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: kGoldenColor,
          onPressed: _listen,
          child: Icon(
            _isListening ?
          Icons.mic :
          Icons.mic_none,
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
        },
        onError: (val) {
          print('onError: $val');
        }
      );
      if (available) {
        setState(() {
          return _isListening  =true;
        });
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0){
              _confidence = val.confidence;
            }
          }),
        );
      }
    }
    else {
      setState(() {
        return _isListening = false;
      });
      _speech.stop();
    }
  }
}
