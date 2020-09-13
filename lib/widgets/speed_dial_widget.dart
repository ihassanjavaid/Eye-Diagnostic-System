
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/reminder_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonWidget{

  Widget speedDial(context) {
    return SpeedDial(
      marginRight: 12.0,
      marginBottom: 12.0,
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 30.0),
      visible: true,
      closeManually: true,
      curve: Curves.bounceIn,
      overlayColor: kTealColor,
      overlayOpacity: 1,
      tooltip: 'Tap to Add a Reminder',
      backgroundColor: kTealColor,
      foregroundColor: Colors.white,
      elevation: 0.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(FontAwesomeIcons.tablets),
          labelBackgroundColor: kTealColor,
          backgroundColor: kAmberColor,
          label: 'Recurring Medicine Schedule',
          labelStyle: kSpeedDialTextStyle,
          onTap: () {
            ReminderDialog(reminderType: ReminderType.RECURRING).announce(context);
          },
        ),
        SpeedDialChild(
          child: Icon(FontAwesomeIcons.calendarPlus),
          labelBackgroundColor: kTealColor,
          backgroundColor: kAmberColor,
          label: 'One-time Reminder',
          labelStyle: kSpeedDialTextStyle,
          onTap: () {
            ReminderDialog(reminderType: ReminderType.ONETIME).announce(context);
          },
        ),
      ],
    );
  }

}
