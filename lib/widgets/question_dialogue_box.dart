import 'package:auto_size_text/auto_size_text.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/choice_chip_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_textfield.dart';

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
  String _email;

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
    String selected;

    return ModalProgressHUD(
      inAsyncCall: _showSpinner,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: 460,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: kTealColor.withOpacity(0.8)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Ask Something',
                      style: kDashboardButtonLabelStyle.copyWith(fontSize: 28,color: kScaffoldBackgroundColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    placeholder: 'Your Post',
                    minLines: 8,
                    placeholderColor: kLightAmberColor,
                    cursorColor: kGoldenColor,
                    focusedOutlineBorder: kLightAmberColor,
                    maxLines: 8,
                    controller: this.messageTextController,
                    onChanged: (value) {
                      questionText = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Choice_Chip(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  child: ButtonTheme(
                    minWidth: double.maxFinite,
                    height: 50,
                    child: RaisedButton(
                      onPressed: ()async{
                        try{
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          _email = pref.getString('email');
                          //_fbuser = await _auth.getCurrentUser();
                          //_uid = _fbuser.uid;
                          selected = Provider.of<ProviderData>(context, listen: false).tagData;
                          _questionService.askQuestion(question: questionText, tag:selected,views: 0,email: _email);
                          _questionsent = true;
                        }catch(e){
                          print(e.toString());
                          throw(e);
                        }
                        messageTextController.clear();
                        Navigator.pop(context);
                      },
                      color: kTealColor,
                      focusColor: kGoldenColor,
                      autofocus: true,
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.comment,
                            color: kLightAmberColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Post',
                              style: kDashboardButtonLabelStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                color: kLightAmberColor
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}