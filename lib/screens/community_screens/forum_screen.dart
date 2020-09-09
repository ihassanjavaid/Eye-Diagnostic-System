import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/forum_question_data.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../extras_screen.dart';

class Forum extends StatefulWidget {
  static const String id = 'forum_screen';
  @override
  _ForumState createState() => _ForumState();
}


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
  bool _userPressed = false;
  bool _tagPressed = false;

  //String selectedTagItem = '';


  Future getAllPosts() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore.collection('questions').get();
    return qn.docs;
  }

  Future getTagPosts() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore
        .collection('questions')
        .where('tag', isEqualTo: Provider.of<ProviderData>(context).tagData)
        .get();
    return qn.docs;
  }

  Future getUserPosts() async{
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    SharedPreferences _pref = await SharedPreferences.getInstance();
    QuerySnapshot qn = await _firestore.collection('questions').where('email', isEqualTo: _pref.getString('email')).get();
    return qn.docs;
  }

  Expanded choosePosts() {
    if(_userPressed){
      setState(() {
        _tagPressed = false;
      });
      return buildExpandedUserPostsSection(context);
    }
    else if(_tagPressed){
      return buildExpandedTagPostsSection(context);
    }
    else
      return buildExpandedQuestionSection(context);
  }



  @override
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
                child: _buildTopPanel(),
              ),
              Container(
                child: choosePosts(),
                 //buildExpandedQuestionSection(context),
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
                  backgroundColor: kTealColor,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<ProviderData>(context, listen: false).updateQuestionData(snapshot.data[index].data()['question']);
                      Provider.of<ProviderData>(context, listen: false).updateQuestionID(snapshot.data[index].id);
                      Navigator.pushNamed(context, ForumDetails.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: kAmberColor,
                        width: 2,
                      ))),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor:  kTealColor.withOpacity(0.8),
                          child: FutureBuilder(
                              future: _userService.getUserInitial(
                                  email: snapshot.data[index].data()['email']),
                              builder: (_, snapshot2) {
                                if (snapshot2.hasData) {
                                  return Text(
                                    snapshot2.data,
                                    style: kAvatarTextStyle,
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: kTealColor,
                                  ));
                                }
                              }),
                          foregroundColor: kTealColor,
                        ),
                        title: Padding(
                          padding:
                              const EdgeInsets.only(left: 2.0, bottom: 5.0),
                          child: Text(
                            snapshot.data[index].data()['question'],
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kTealColor),
                          ),
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0)),
                                color: kTealColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 1.5),
                              child: Text(
                                snapshot.data[index].data()['tag'],
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: kLightTealColor),
                              ),
                            ),
                          ),
                        ),
                        trailing: Chip(
                          backgroundColor: kAmberColor.withOpacity(0.7),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text(
                            snapshot.data[index].data()['views'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kLightTealColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
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
                  backgroundColor: kTealColor,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<ProviderData>(context, listen: false).updateQuestionData(snapshot.data[index].data()['question']);
                      Provider.of<ProviderData>(context, listen: false).updateQuestionID(snapshot.data[index].id);
                      Navigator.pushNamed(context, ForumDetails.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: kAmberColor,
                        width: 2,
                      ))),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: kTealColor.withOpacity(0.8),
                          child: FutureBuilder(
                              future: _userService.getUserInitial(
                                  email: snapshot.data[index].data()['email']),
                              builder: (_, snapshot2) {
                                if (snapshot2.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      snapshot2.data,
                                      style: kAvatarTextStyle,
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: kTealColor,
                                  ));
                                }
                              }),
                          foregroundColor: kTealColor,
                        ),
                        title: Padding(
                          padding:
                              const EdgeInsets.only(left: 2.0, bottom: 5.0),
                          child: Text(
                            snapshot.data[index].data()['question'],
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kTealColor),
                          ),
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0)),
                                color: kTealColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 1.5),
                              child: Text(
                                snapshot.data[index].data()['tag'],
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    color: kLightTealColor),
                              ),
                            ),
                          ),
                        ),
                        trailing: Chip(
                          backgroundColor: kLightAmberColor,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text(
                            snapshot.data[index].data()['views'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kLightTealColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  Expanded buildExpandedUserPostsSection(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: getUserPosts(),
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
                    onTap: () {
                      Provider.of<ProviderData>(context, listen: false).updateQuestionData(snapshot.data[index].data()['question']);
                      Provider.of<ProviderData>(context, listen: false).updateQuestionID(snapshot.data[index].id);
                      Navigator.pushNamed(context, ForumDetails.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: kAmberColor,
                                width: 2,
                              ))),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundColor: kTealColor.withOpacity(0.8),
                          child: FutureBuilder(
                              future: _userService.getUserInitial(
                                  email: snapshot.data[index].data()['email']),
                              builder: (_, snapshot2) {
                                if (snapshot2.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      snapshot2.data,
                                      style: kAvatarTextStyle,
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: kTealColor,
                                      ));
                                }
                              }),
                          foregroundColor: kTealColor,
                        ),
                        title: Padding(
                          padding:
                          const EdgeInsets.only(left: 2.0, bottom: 5.0),
                          child: Text(
                            snapshot.data[index].data()['question'],
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kTealColor),
                          ),
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0)),
                                color: kTealColor),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 1.5),
                              child: Text(
                                snapshot.data[index].data()['tag'],
                                style: TextStyle(
                                  //fontWeight: FontWeight.bold,
                                    color: kLightTealColor),
                              ),
                            ),
                          ),
                        ),
                        trailing: Chip(
                          backgroundColor: kLightAmberColor,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text(
                            snapshot.data[index].data()['views'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: kLightTealColor),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  Widget _buildTopPanel() {
    return ClipPath(
      clipper: HeaderCustomClipper(),
      child: Column(
        children: [
          Container(
            color: kTealColor,
            padding: const EdgeInsets.only(left: 15, right: 15, top: 32.0, bottom: 10.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'EyeSee\t',
                      style: kDashboardTitleTextStyle.copyWith(
                          color: kAmberColor),
                    ),
                    TextSpan(
                      text: 'Forums',
                      style: kDashboardTitleTextStyle.copyWith(
                          color: kAmberColor),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Container(
            color: kTealColor,
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
                            setState(() {
                              _userPressed = true;
                            });
                            // Navigator.pushNamed(context, ForumUserQuestions.id);
                          },
                          child: Icon(
                            Icons.person,
                            color: kAmberColor,
                            size: 34.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Asked', style: kforumHeaderButtonLabelStyle),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            msgdlg.announce(context);
                            //selectedTagItem = selectedTag;
                          },
                          child: Icon(
                            Icons.add_comment_rounded,
                            color: kAmberColor,
                            size: 34.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('New', style: kforumHeaderButtonLabelStyle),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _tagPressed = true;
                              _userPressed = false;
                            });
                            await tgsdlg.showCard(context);
                          },
                          child: Icon(
                            Icons.tag,
                            color: kAmberColor,
                            size: 34.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Tags', style: kforumHeaderButtonLabelStyle),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _userPressed = false;
                              _tagPressed = false;
                              Provider.of<ProviderData>(context, listen: false).updateTagData('');
                            });
                          },
                          child: Icon(
                            Icons.refresh_rounded,
                            color: kAmberColor,
                            size: 34.0,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text('Refresh', style: kforumHeaderButtonLabelStyle),
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

  /*void refreshScreen(){
    setState(() {
      selectedTagItem = selectedTag;
    });
  }*/
}
