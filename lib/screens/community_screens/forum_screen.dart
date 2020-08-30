import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Forum extends StatefulWidget {
  static const String id = 'forum_screen';
  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height * 0.33,
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
                actions: <Widget>[
                  new Icon(Icons.search, size: 30.0,),
                  new SizedBox(width: 8.0,),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 90.0,
                  ),
                  Container(
                    child:_buildForumTypesContainer(),
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
            height: 10.0,
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

  Container _buildForumTypesContainer() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.local_hospital,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Hospitals',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.money,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Expenses',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.sick,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Symptoms',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.wheelchair_pickup,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Disability',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.people,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Family',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.help_center,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Questions',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.question_answer,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Suggestions',
                      style: TextStyle(
                        color: kDeepGoldenColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                        Icons.support_agent,
                        color: kDeepGoldenColor,
                        size: 24.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Support',
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
  }

