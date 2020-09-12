import 'package:eye_diagnostic_system/services/firestore_reminder_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertWidget{
  generateAlert({ @required context, @required title, @required description}){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            /*
            * popping the context 2 times
            * first pops the dialog
            * second pops the loading screen and returns back to the sign-in/reg screen
            */
            Navigator.pop(context);
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );
  }

  generateReminderDelete({@required BuildContext context ,@required String title}){
    FirestoreReminderService _firestoreReminderService = FirestoreReminderService();

    return Alert(
      context: context,
      type: AlertType.warning,
      title: title,
      desc: 'Are you sure you want to delete this reminder?',
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 80,
        ),
        DialogButton(
          color: Colors.red,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            try{
              _firestoreReminderService.deleteReminder(title);
            } catch (e) {
              print(e);
            }
            Navigator.pop(context);
          },
          width: 80,
        )
      ],
    );
  }
}