import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'package:eye_diagnostic_system/models/forum_answer_data.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';
import 'package:eye_diagnostic_system/services/firestore_answer_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/answer_dialog_box.dart';
import 'package:eye_diagnostic_system/widgets/speed_dial_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class ForumDetails extends StatefulWidget {
  static const String id = 'forum_detail_screen';
  @override
  _ForumDetailsState createState() => _ForumDetailsState();
}


class _ForumDetailsState extends State<ForumDetails> {
  @override
  AnswerDialog _answerDialog = AnswerDialog();
  FirestoreAnswerService _answerService = FirestoreAnswerService();



  Expanded buildExpandedAnswerSection(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future: _answerService.getAnswers(
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
      /*floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.comment,
        ),
        backgroundColor: kAmberColor,
        foregroundColor: kLightTealColor,
        tooltip: 'Answer',
        onPressed: (){
          _answerDialog.showCard(context);
        },
      ),*/
      floatingActionButton: ButtonWidget().speedDialForum(context),

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
                left: 15, right: 15, top: 10.0, bottom: 10.0),
            alignment: Alignment.center,
          ),
          Container(
            color: kTealColor,
            height: 170,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
              ],
            ),
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
                color: kAmberColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
