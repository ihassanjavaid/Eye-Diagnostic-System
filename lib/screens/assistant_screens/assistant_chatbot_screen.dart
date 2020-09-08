import 'package:bubble/bubble.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/components/pages.dart';
import 'package:eye_diagnostic_system/screens/assistant_screens/assistant_voice_screen.dart';
import 'package:eye_diagnostic_system/services/dialogflow_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Assistant extends StatefulWidget {
  static const String id = 'assistant_screen';
  Assistant({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  final messageInsertController = TextEditingController();
  List<Map> messsagesList = List();
  DialogFlowService _dialogFlowService = DialogFlowService();

  Future<String> getUserInitial() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String _name = _pref.getString('displayName');
    return _name[0];
  }

  void response(query) async {

    AIResponse aiResponse = await _dialogFlowService.getResponseFromDialogFlow(query);

    setState(() {
      messsagesList.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    String intentName = '';
    // text response
    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
    // intent name response
    intentName = aiResponse.queryResult.intent.displayName;
    print(intentName);

    // navigate
    if (Pages.isAvailable(intentName)){
      Navigator.popAndPushNamed(context, intentName);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                            text: 'Assistant',
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
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsagesList.length,
                    itemBuilder: (context, index) => chat(
                        messsagesList[index]["message"].toString(),
                        messsagesList[index]["data"]))),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5.0,
              color: kAmberColor,
            ),
            Container(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: kTealColor,
                    size: 36,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AssistantVoice.id);
                },
                ),
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: kTealColor.withOpacity(0.9),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsertController,
                    decoration: InputDecoration(
                      hintText: 'Say Something!',
                      hintStyle: kHintTextStyle,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: kHintTextStyle.copyWith(color: Colors.white),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 36.0,
                      color: kTealColor,
                    ),
                    onPressed: () {
                      if (messageInsertController.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          messsagesList.insert(
                              0, {"data": 1, "message": messageInsertController.text});
                        });
                        response(messageInsertController.text);
                        messageInsertController.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 3.0,
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 35.0,
                  width: 55.0,
                  child: CircleAvatar(
                    backgroundColor: kScaffoldBackgroundColor,
                    backgroundImage: AssetImage('assets/images/eye.png'),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Bubble(
                radius: Radius.circular(8.0),
                color: data == 0
                    ? kTealColor
                    : kTealColor.withOpacity(0.5) ,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Text(
                            message,
                            style: kHintTextStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      )
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 45.0,
                  width: 45.0,
                  child: CircleAvatar(
                    maxRadius: 10.0,
                    backgroundColor: kTealColor,
                    child: FutureBuilder(
                      future: getUserInitial(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData){
                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 1.0),
                            child: Text(
                              snapshot.data,
                              style: kHintTextStyle.copyWith(fontSize: 30.0, color: kLightTealColor),
                            ),
                          );
                        }
                        else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
