import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/forum_question_data.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_detail_screen.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/question_dialogue_box.dart';
import 'package:eye_diagnostic_system/widgets/tags_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
String selectedTagItem;

class _ForumState extends State<Forum> {
  String _uid;
  bool _showSpinner = false;
  FirestoreQuestionService _questionService = FirestoreQuestionService();
  MessageDialog msgdlg = MessageDialog();
  TagsDialog tgsdlg = TagsDialog();
  User _fbuser;
  Auth _auth = Auth();
  List<Question> _questions = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirestoreUserService _userService = FirestoreUserService();


  Future getAllPosts() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore.collection('questions').get();
    return qn.docs;
  }

  Future getTagPosts() async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore.collection('questions').where('tag', isEqualTo: selectedTagItem).get();
    return qn.docs;
  }

  Widget choosePosts() {
    if (selectedTagItem == ''){
      return buildExpandedQuestionSection(context);
    }
    else{

      return buildExpandedTagPostsSection(context);
    }
  }

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
          child:  Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: kPurpleColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'EyeSee\t',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kGoldenColor),
                            ),
                            TextSpan(
                              text: 'Forums',
                              style: kDashboardTitleTextStyle.copyWith(
                                  color: kGoldenColor),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: _buildTopPanel(),
              ),
             /* Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                child:  Text(
                  "All Posts",
                  style:  TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
              ),
               SizedBox(
                height: 5.0,
              ),*/
                 Container (
                     child: choosePosts(),
                 ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpandedQuestionSection(BuildContext context) {
    return Expanded(
              child: FutureBuilder(
                  future: getAllPosts(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kPurpleColor,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, ForumDetails.id);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: kGoldenColor,
                                width: 2,
                              ))),
                              child:  ListTile(
                                leading:  CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: kDeepGoldenColor,
                                  child: FutureBuilder(
                                      future: _userService.getUserInitial(
                                          email: snapshot.data[index]
                                              .data()['email']),
                                      builder: (_, snapshot2) {
                                        if (snapshot2.hasData) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.only(top:4.0),
                                              child: Text(
                                                  snapshot2.data,
                                                  style: kAvatarTextStyle,
                                              ),
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator(
                                            backgroundColor: kPurpleColor,
                                          ));
                                        }
                                      }),
                                  foregroundColor: kPurpleColor,
                                ),
                                title:  Padding(
                                  padding: const EdgeInsets.only(left: 2.0, bottom: 5.0),
                                  child: Text(
                                    snapshot.data[index].data()['question'],
                                    style:  TextStyle(
                                      fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white70
                                    ),
                                  ),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20.0),
                                          bottomRight: Radius.circular(20.0)
                                      ),
                                  color: kDarkPurpleColor
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 1.5),
                                      child: Text(
                                        snapshot.data[index].data()['tag'],
                                        style:  TextStyle(
                                          //fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                trailing:  Chip(
                                  backgroundColor: kGoldenColor,
                                  shape: BeveledRectangleBorder(
                                    borderRadius:
                                         BorderRadius.circular(10),
                                  ),
                                  label:  Text(
                                    snapshot.data[index]
                                        .data()['views']
                                        .toString(),
                                    style:  TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  ),
            );
  }

  Expanded buildExpandedTagPostsSection(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: getTagPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: kPurpleColor,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ForumDetails.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: kGoldenColor,
                                width: 2,
                              ))),
                      child:  ListTile(
                        leading:  CircleAvatar(
                          radius: 25.0,
                          backgroundColor: kDeepGoldenColor,
                          child: FutureBuilder(
                              future: _userService.getUserInitial(
                                  email: snapshot.data[index]
                                      .data()['email']),
                              builder: (_, snapshot2) {
                                if (snapshot2.hasData) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.only(top:4.0),
                                    child: Text(
                                      snapshot2.data,
                                      style: kAvatarTextStyle,
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child:
                                      CircularProgressIndicator(
                                        backgroundColor: kPurpleColor,
                                      ));
                                }
                              }),
                          foregroundColor: kPurpleColor,
                        ),
                        title:  Padding(
                          padding: const EdgeInsets.only(left: 2.0, bottom: 5.0),
                          child: Text(
                            snapshot.data[index].data()['question'],
                            style:  TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70
                            ),
                          ),
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0)
                                ),
                                color: kDarkPurpleColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 1.5),
                              child: Text(
                                snapshot.data[index].data()['tag'],
                                style:  TextStyle(
                                  //fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        trailing:  Chip(
                          backgroundColor: kGoldenColor,
                          shape: BeveledRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          label:  Text(
                            snapshot.data[index]
                                .data()['views']
                                .toString(),
                            style:  TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
      ),
    );
  }

  Widget _buildTopPanel() {
    return ClipPath(
      clipper: HeaderCustomClipper(),
      child: Container(
        color: kPurpleColor,
        height: 120,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _questions = await _getQuestions();
                        // Navigator.pushNamed(context, ForumUserQuestions.id);
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
                      style: kforumHeaderButtonLabelStyle
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
                      style: kforumHeaderButtonLabelStyle
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        tgsdlg.showCard(context);
                        selectedTagItem = selectedTag;
                        choosePosts();
                        selectedTagItem = '';

                      },
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
                      style: kforumHeaderButtonLabelStyle
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

  Future<List<Question>> _getQuestions() async {
    _fbuser = await _auth.getCurrentUser();
    _uid = _fbuser.uid;
    List<Question> questions = await _questionService.getUserQuestions(_uid);
    return questions;
  }

  Future<List<Question>> _getAllQuestions() async {
    _questions = await _questionService.getAllQuestions();
    return _questions;
  }
}
