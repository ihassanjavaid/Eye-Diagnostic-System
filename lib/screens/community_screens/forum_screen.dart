import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/question_dialogue_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../extras_screen.dart';

class Forum extends StatefulWidget {
  static const String id = 'forum_screen';
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  Future<String> _uid;
  bool _showSpinner = false;
  FirestoreQuestionService _firestoreQestionService =
      FirestoreQuestionService();
  MessageDialog msgdlg = MessageDialog();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: kBgColorGradientArrayBlues,
            ),
          ),
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'EyeSee\t',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kPurpleColor),
                            ),
                            TextSpan(
                              text: 'Forums',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kGoldenColor),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      Container(
                        child: _buildTopPanel(),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                child: new Text(
                  "All Posts",
                  style: new TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
              ),
              new SizedBox(
                height: 5.0,
              ),
              new Expanded(
                child: new ListView.builder(
                  itemCount: 15,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForumDetails.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(

                        ),
                        child: new ListTile(
                          leading: new CircleAvatar(
                            radius: 25.0,
                            backgroundColor: kDeepGoldenColor,
                            child: new Text("A"),
                            foregroundColor: kPurpleColor,
                          ),
                          title: new Text(
                            "I was diagnosed with Galucoma. Who else was diagnosed?",
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white70
                            ),
                          ),
                          subtitle: new Row(
                            children: <Widget>[
                              new Chip(
                                backgroundColor: Color(0xff611cdf),
                                label: new Text(
                                  "Diseases",
                                  style: new TextStyle(
                                      //fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          trailing: new Chip(
                            backgroundColor: kGoldenColor,
                            shape: BeveledRectangleBorder(
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            label: new Text(
                              "25 Replies",
                              style: new TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kPurpleColor,
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Extras.id);
                      },
                      child: Icon(
                        Icons.person,
                        color: kDeepGoldenColor,
                        size: 34.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Asked',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        msgdlg.announce(context);
                      },
                      child: Icon(
                        Icons.add_comment_rounded,
                        color: kDeepGoldenColor,
                        size: 34.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'New',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.tag,
                        color: kDeepGoldenColor,
                        size: 34.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Tags',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserID() async {
    String _uid;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _uid = pref.getString('uid');
    return _uid;
  }
}
