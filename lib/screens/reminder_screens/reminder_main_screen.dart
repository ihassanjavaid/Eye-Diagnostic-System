import 'package:flutter/material.dart';

class ReminderMain extends StatefulWidget {
  static const String id = 'reminder_main_screen';

  @override
  _ReminderMainState createState() => _ReminderMainState();
}

class _ReminderMainState extends State<ReminderMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    /*  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        *//*decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: kBgColorGradientArrayBlues,
          ),
        ),*//*
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
      ),*/
    );
  }

}
