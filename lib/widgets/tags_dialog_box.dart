import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/choice_chip_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TagsDialog {
  TagsDialog({this.receiverEmail});

  final String receiverEmail;
  final messageTitleController = TextEditingController();
  final messageTextController = TextEditingController();

  bool _showSpinner = false;

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
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: kTealColor.withOpacity(0.8)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Search by Tag',
                      style: kDashboardButtonLabelStyle.copyWith(fontSize: 28,color: kScaffoldBackgroundColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ChoiceChipWidget(),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.check,
                        size: 34.0,
                        color: kAmberColor,
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