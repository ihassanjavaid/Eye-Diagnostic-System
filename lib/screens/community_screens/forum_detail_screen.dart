import 'dart:ui';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForumDetails extends StatefulWidget {
  static const String id = 'forum_detail_screen';
  @override
  _ForumDetailsState createState() => _ForumDetailsState();
}

var ForumPostArr = [
  new ForumPostEntry("User1", "2 Days ago", 0, 0,
      "Hello,\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  new ForumPostEntry("User2", "23 Hours ago", 1, 0,
      "Pellentesque justo metus, finibus porttitor consequat vitae, tincidunt vitae quam. Vestibulum molestie sem diam. Nullam pretium semper tempus. Maecenas lobortis lacus nunc, id lacinia nunc imperdiet tempor. Mauris mi ipsum, finibus consectetur eleifend a, maximus eget lorem. Praesent a magna nibh. In congue sapien sed velit mattis sodales. Nam tempus pulvinar metus, in gravida elit tincidunt in. Curabitur sed sapien commodo, fringilla tortor eu, accumsan est. Proin tincidunt convallis dolor, a faucibus sapien auctor sodales. Duis vitae dapibus metus. Nulla sit amet porta ipsum, posuere tempor tortor.\n\nCurabitur mauris dolor, cursus et mi id, mattis sagittis velit. Duis eleifend mi et ante aliquam elementum. Ut feugiat diam enim, at placerat elit semper vitae. Phasellus vulputate quis ex eu dictum. Cras sapien magna, faucibus at lacus vel, faucibus viverra lorem. Phasellus quis dui tristique, ultricies velit non, cursus lectus. Suspendisse neque nisl, vestibulum non dui in, vulputate placerat elit. Sed at convallis mauris, eu blandit dolor. Vivamus suscipit iaculis erat eu condimentum. Aliquam erat volutpat. Curabitur posuere commodo arcu vel consectetur."),
  new ForumPostEntry("User3", "2 Days ago", 5, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  new ForumPostEntry("User4", "2 Days ago", 0, 0,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
];

class ForumPostEntry {
  final String username;
  final String hours;
  int likes;
  int dislikes;
  final String text;

  ForumPostEntry(
      this.username, this.hours, this.likes, this.dislikes, this.text);
}

class _ForumDetailsState extends State<ForumDetails> {
  @override
  Widget build(BuildContext context) {
    var questionSection = _buildQuestionSection();
    var responses = new Container(
        padding: const EdgeInsets.all(8.0),
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              new ForumPost(ForumPostArr[index]),
          itemCount: ForumPostArr.length,
        ));

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
              child: Column(
                children: [
                  new Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(child: questionSection),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          SizedBox(
                            height: 550,
                            child: responses,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  Container _buildQuestionSection() {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
          color: kDeepGoldenColor,
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          border: Border.all(
            color: kDeepGoldenColor,
            width: 2.0,
          )),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(
            "How do I become a expert in programming as well as design??",
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[


              ],
            ),
          ),
        ],
      ),
    );
  }

  /*Padding _buildQuestionSection() {
    return new Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: new Column(
        children: <Widget>[
          new Text(
            "How do I become a expert in programming as well as design??",
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Chip(
                  backgroundColor: kDeepGoldenColor,
                  shape: BeveledRectangleBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  label: new Text(
                    "Disease",
                    style: new TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ),
                */ /*new IconWithText(
                  Icons.check_circle,
                  "Answered",
                  iconColor: kDeepGoldenColor,
                ),*/ /*
                new IconWithText(
                  Icons.remove_red_eye,
                  "54",
                  iconColor: kDeepGoldenColor,
                )
              ],
            ),
          ),
          new Divider()
        ],
      ),
    );
  }*/

}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;
  ForumPost(this.entry);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: new Column(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Color(0xFF4563DB),
              borderRadius: const BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0)),
            ),
            child: new Row(
              children: <Widget>[
                new Icon(Icons.person, size: 50.0, color: Colors.black38),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        entry.username,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      new Text(
                        entry.hours,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () {},
                        child:
                            new Icon(Icons.thumb_up, color: kDeepGoldenColor),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: new Text(
                        entry.likes.toString(),
                        style: TextStyle(
                            color: kDeepGoldenColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: new Icon(Icons.thumb_down, color: Colors.grey),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                      child: new Text(
                        entry.dislikes.toString(),
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
            padding: const EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0))),
            child: new Text(entry.text),
          ),
        ],
      ),
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;

  IconWithText(this.iconData, this.text, {this.iconColor});
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Icon(
            this.iconData,
            color: this.iconColor,
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: new Text(
              this.text,
              style: TextStyle(
                color: kGoldenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
