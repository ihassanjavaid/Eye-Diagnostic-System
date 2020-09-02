import 'package:auto_size_text/auto_size_text.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../utilities/custom_textfield.dart';

class MessageDialog {
  MessageDialog({this.receiverEmail});

  final String receiverEmail;
 //final FirestoreService _firestoreService = FirestoreService();
  final messageTitleController = TextEditingController();
  final messageTextController = TextEditingController();

  bool _showSpinner = false;
  bool _questionsent = false;

  FirestoreQuestionService _questionService = FirestoreQuestionService();
  User _fbuser;
  Auth _auth = Auth();
  String _uid;

  announce(context) {
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
              child: _announcementCard(context),
            ),
          );
        });
  }

  _announcementCard(context) {
    String messageTitle;
    String questionText;

    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: Container(
        height: 350,
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
                    'Ask a Question',
                    style: kDashboardButtonLabelStyle.copyWith(fontSize: 28,color: Colors.white70),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  placeholder: 'Your Post',
                  minLines: 8,
                  placeholderColor: kDeepGoldenColor,
                  cursorColor: kGoldenColor,
                  focusedOutlineBorder: kGoldenColor,
                  maxLines: null,
                  controller: this.messageTextController,
                  onChanged: (value) {
                    questionText = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ButtonTheme(
                  minWidth: double.maxFinite,
                  height: 50,
                  child: RaisedButton(
                    onPressed: ()async{
                      try{
                        _fbuser = await _auth.getCurrentUser();
                        _uid = _fbuser.uid;
                        _questionService.askQuestion(question: questionText, tag:'Disease',views: 0,uID: _uid);
                        _questionsent = true;
                      }catch(e){
                        print(e.toString());
                        throw(e);
                      }
                      messageTextController.clear();
                      Navigator.pop(context);
                    },
                    color: kPurpleColor,
                    focusColor: kGoldenColor,
                    autofocus: true,
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.comment,
                          color: kGoldenColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Post',
                            style: kDashboardButtonLabelStyle.copyWith(fontSize: 20,fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    ),
                    /*onPressed: () async {
                      _showSpinner = true;
                      // Push the message to the contact
                      try {
                        await _firestoreService.postMessage(
                            messageTitle: messageTitle,
                            messageText: messageText,
                            receiverEmail: this.receiverEmail,
                            messageType: MessageType.privateMessage);
                        this.messageTitleController.clear();
                        this.messageTextController.clear();
                      } catch (e) {
                        print(e);
                      }
                      _showSpinner = false;
                    },*/
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}