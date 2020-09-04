import 'package:auto_size_text/auto_size_text.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/choice_chip_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eye_diagnostic_system/screens/community_screens/forum_screen.dart';

import '../utilities/custom_textfield.dart';

String selectedTag = '';


class TagsDialog {
  TagsDialog({this.receiverEmail});

  final String receiverEmail;
  //final FirestoreService _firestoreService = FirestoreService();
  final messageTitleController = TextEditingController();
  final messageTextController = TextEditingController();

  bool _showSpinner = false;

  Forum _forum = Forum();


  Future showCard(context) {
    showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: _tagsCard(context),
            ),
          );
        });
  }

  _tagsCard(context) {
    String messageTitle;
    String questionText;
    String selected;

    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: kBgColorGradientArrayBlues,
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'Search by Tag',
                      style: kDashboardButtonLabelStyle.copyWith(fontSize: 28,color: Colors.white70),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Choice_Chip(),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: GestureDetector(
                      onTap: (){
                          selectedTag = globalSelectedItem;
                          Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.check,
                        size: 34.0,
                        color: kGoldenColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}