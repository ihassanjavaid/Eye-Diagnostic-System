import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_question_screen.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forum extends StatefulWidget {
  static const String id = 'forum_screen';
  @override
  _ForumState createState() => _ForumState();
}


class _ForumState extends State<Forum> {
Future <String> _uid;
FirestoreQuestionService _firestoreQestionService = FirestoreQuestionService();

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width:  MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        colors:  [
                          Color(0xFF3594DD),
                          Color(0xFF4563DB),
                          Color(0xff611cdf)
                        ]
                    ),
                    borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                    )
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Row(
                    children:[
                      Image(
                        image: AssetImage('assets/images/eye.png'),
                        height: 40,
                        width: 40,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Community Forums',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.13,
                  ),
                  Container(
                    child:_buildTopPanel(),
                  ),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text("All Posts",
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0
              ),
            ),
          ),
          new SizedBox(
            height: 5.0,
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount:  15,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ForumDetails.id);
                  },
                  child: new ListTile(
                    leading: new CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.blueGrey,
                      child: new Text("User"),
                      foregroundColor: Colors.white,
                    ),
                    title: new Text("I was diagnosed with Galucoma. Who else was diagnosed?",
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: new Row(
                      children: <Widget>[
                        new Chip(
                          backgroundColor: Color(0xff611cdf),
                          label: new Text("Diseases",
                            style: new TextStyle(
                              //fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: new Chip(
                      backgroundColor: kGoldenColor,
                      shape: BeveledRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      label: new Text("25 Replies",
                        style: new TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ) ;
              },
            ),
          )
        ],
      ),
    ) ;
  }

  Container _buildTopPanel() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
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
                      'Profile',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0, right: 25),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                       Navigator.pushNamed(context, QuestionScreen.id);
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
                      'Question',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0, right: 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
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
              ),
            ],

          ),
        ],
      ),
    );
  }

  Future<String> _getUserID() async {
    String _uid;
    final SharedPreferences pref =
    await SharedPreferences.getInstance();
    _uid = pref.getString('uid');
    return _uid;
  }
  }

