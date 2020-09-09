import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/forum_answer_data.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/services/firestore_answer_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/answer_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
  AnswerDialog _answerDialog = AnswerDialog();
  FirestoreAnswerService _answerService = FirestoreAnswerService();

  Future getAnswers(String id) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore
        .collection('answers')
        .where('questionID', isEqualTo: id)
        .get();
    return qn.docs;
  }

  Expanded buildExpandedAnswerSection(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: getAnswers(
            Provider.of<ProviderData>(context, listen: true).questionID,
          ),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: kTealColor,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: new BoxDecoration(
                          color: kLightTealColor,
                          border: Border.all(
                            color: kTealColor,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0))),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: new BoxDecoration(
                                color: kTealColor.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                    topLeft: const Radius.circular(18.0),
                                    topRight: const Radius.circular(18.0))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, top: 4.0, bottom: 4.0, right:8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              Icons.person,
                                            size: 30,
                                            color: kTealColor.withOpacity(0.7),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data[index].data()['userName'],
                                              style: TextStyle(
                                                color: kScaffoldBackgroundColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          new Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                Provider.of<ProviderData>(context, listen: false).updateAnswerID(snapshot.data[index].id);
                                                int klikes = snapshot.data[index].data()['likes'];
                                                _answerService.like(Provider.of<ProviderData>(context, listen: false).answerID, klikes);
                                              },
                                              child: new Icon(
                                                  Icons.thumb_up,
                                                  color: kAmberColor
                                              ),
                                            ),
                                          ),
                                          new Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: new Text(
                                              snapshot.data[index].data()['likes'].toString(),
                                              style: TextStyle(
                                                  color: kAmberColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          new Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                Provider.of<ProviderData>(context, listen: false).updateAnswerID(snapshot.data[index].id);
                                                int kdislikes = snapshot.data[index].data()['dislikes'];
                                                _answerService.dislike(Provider.of<ProviderData>(context, listen: false).answerID, kdislikes);
                                              },
                                              child: new Icon(
                                                  Icons.thumb_down,
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ),
                                          new Padding(
                                            padding: const EdgeInsets.only(right: 8.0, left: 2.0),
                                            child: new Text(
                                              snapshot.data[index].data()['dislikes'].toString(),
                                              style: TextStyle(
                                                  color: Colors.grey, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],

                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, bottom: 5.0),
                              child: Text(
                                snapshot.data[index].data()['answer'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: kTealColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: kScaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: kTealColor,
                ),
              ),
              Container(
                child: _questionPanel(),
              ),
              Container(
                child: buildExpandedAnswerSection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionPanel() {
    return ClipPath(
      clipper: HeaderCustomClipper(),
      child: Column(
        children: [
          Container(
            color: kTealColor,
            padding: const EdgeInsets.only(
                left: 15, right: 15, top: 20.0, bottom: 10.0),
            alignment: Alignment.center,
          ),
          Container(
            color: kTealColor,
            height: 170,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    Provider.of<ProviderData>(context, listen: false)
                        .questionData,
                    textScaleFactor: 1.5,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _answerDialog.showCard(context);
                          },
                          child: Icon(
                            Icons.comment,
                            color: kAmberColor,
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Answer',
                            style:
                                kLoginLabelStyle.copyWith(color: kAmberColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForumPost extends StatelessWidget {
  final ForumPostEntry entry;
  ForumPost(this.entry);
  @override
  Widget build(BuildContext context) {
    //return buildAnswerSection();
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
                color: kAmberColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
