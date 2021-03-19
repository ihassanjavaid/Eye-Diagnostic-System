import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/screens/diagnosis_screens/image_picker_screen.dart';
import 'package:eye_diagnostic_system/screens/reminder_screens/reminder_main_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/astigmatism_test_screen.dart';
import 'package:eye_diagnostic_system/screens/vision_testing_screens/duochrome_test_screen.dart';
import 'package:eye_diagnostic_system/services/firestore_reminder_services.dart';
import 'package:eye_diagnostic_system/services/screen_arguments.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertWidget{

  // Alert for sign-in/registration fail
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

  // confirmation for deleting a reminder
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

            // Pop context once and re-build the reminder screen to refresh reminders
            Navigator.pop(context);
            Navigator.pushNamed(context, ReminderMain.id);

            Provider.of<ProviderData>(context, listen: false).updateModelString('');
          },
          width: 80,
        )
      ],
    );
  }

  generateAlertInvalidDiagnosis({@required context, @required title, @required description, @required diagnosisType}){
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
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushNamed(context,
                ImagePickerScreen.id,
                arguments: ScreenArguments(diagnosisType)
            );
          },
          width: 130,
        )
      ],
    );
  }

  generatePlaceDetailDialog({@required context, @required title, @required description, @required onCallTap, @required onDirectionsTap}){
    return Alert(
      context: context,
      image: Container(
        height: 120,
        width: 120,
        child: Image.asset(
          'assets/images/places/hosp_icon.png',
        ),
      ),
      //type: AlertType.info,
      title: title,
      desc: description,
      style: AlertStyle(
        titleStyle: kReminderMainTextStyle.copyWith(fontSize: 24.0),
        descStyle: kReminderSubtitleTextStyle
      ),
      buttons: [
        DialogButton(
          color: kDiseaseIndicationColor,
          child: Text(
            "Call",
            style: kAlertButtonTextStyle,
          ),
          onPressed: onCallTap,
          width: 130,
        ),
        DialogButton(
          color: kTealColor,
          child: Text(
            "Directions",
            style: kAlertButtonTextStyle,
          ),
          onPressed: onDirectionsTap,
          width: 130,
        )
      ],
    );
  }

  generateDisclaimer({@required context}){
    return Alert(
      context: context,
      image: Container(
          height: 50,
          width: 50,
          child: Icon(
            CupertinoIcons.info,
            size: 50,
            color: kAmberColor,
          )
      ),
      title: 'Disclaimer',
      desc: 'EyeSee does not serve as a complete replacement for licensed professionals. Please seek professional advice from your local optometrist for an accurate diagnosis',
      style: AlertStyle(
          titleStyle: kReminderMainTextStyle.copyWith(fontSize: 24.0),
          descStyle: kReminderSubtitleTextStyle
      ),
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "I Understand",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );

  }

  generatePastTimeAlert({@required context}){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: 'Invalid Time',
      desc: 'Sorry, the date/time you have selected has passed!\nPlease try again.',
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );
  }

  generateInstructions({ @required context, @required title, @required description}){
    return Alert(
      context: context,
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

  generateDuoEyeAlert({ @required context, @required title, @required description}){
    return Alert(
      context: context,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            /*
            * popping the context 2 times
            * first pops the dialog
            * second pops the loading screen and returns back to the sign-in/reg screen
            */
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => DuochromeTestScreen(
              eyeType: EyeType.LEFT,
            )));
          },
          width: 130,
        )
      ],
    );
  }
  generateAstigEyeAlert({ @required context, @required title, @required description}){
    return Alert(
      context: context,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Proceed",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            /*
            * popping the context 2 times
            * first pops the dialog
            * second pops the loading screen and returns back to the sign-in/reg screen
            */
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => AstigmatismTestScreen(
              eyeType: EyeType.LEFT,
            )));
          },
          width: 130,
        )
      ],
    );
  }

  generateBiometricErrorAlert({@required context, @required title}){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: 'Can\'t Authenticate',
      desc: title,
      buttons: [
        DialogButton(
          color: kTealColor,
          child: Text(
            "Dismiss",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 130,
        )
      ],
    );
  }
}