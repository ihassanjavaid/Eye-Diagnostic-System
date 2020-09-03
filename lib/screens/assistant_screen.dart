import 'package:bubble/bubble.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
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
  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  Future<String> getUserInitial() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    String _name = _pref.getString('displayName');
    return _name[0];
  }

  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/json/service.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });

    print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: kBgColorGradientArrayBlues,
          ),
        ),
        child: Column(
          children: <Widget>[
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
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5.0,
              color: kGoldenColor,
            ),
            Container(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: kGoldenColor,
                    size: 36,
                  ),
                ),
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: kPurpleColor,
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
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
                      color: kGoldenColor,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          messsages.insert(
                              0, {"data": 1, "message": messageInsert.text});
                        });
                        response(messageInsert.text);
                        messageInsert.clear();
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

  //for better one i have use the bubble package check out the pubspec.yaml

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
                    backgroundImage: AssetImage('assets/images/eye.png'),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Bubble(
                radius: Radius.circular(8.0),
                color: data == 0
                    ? kDarkPurpleColor
                    : Colors.grey ,
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
                    backgroundColor: kDeepGoldenColor,
                    child: FutureBuilder(
                      future: getUserInitial(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData){
                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 1.0),
                            child: Text(
                              snapshot.data,
                              style: kHintTextStyle.copyWith(fontSize: 30.0, color: Colors.white),
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
