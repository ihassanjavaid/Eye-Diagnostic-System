import 'package:auto_size_text/auto_size_text.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/models/reminder_data.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_question_services.dart';
import 'package:eye_diagnostic_system/services/firestore_reminder_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/choice_chip_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_textfield.dart';

class ReminderDialog {
  ReminderDialog({@required this.reminderType});

  final ReminderType reminderType;
  final _titleTextController = TextEditingController();
  FirestoreReminderService _firestoreReminderService = FirestoreReminderService();

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
              child: reminderType == ReminderType.ONETIME
                  ? _announcementCardForOneTime(context)
                  : _announcementCardForRecurring(context),
            ),
          );
        });
  }

  _announcementCardForOneTime(context) {
    Reminder _reminder = Reminder();
    TimeOfDay _pickedTime = TimeOfDay.fromDateTime(DateTime.now());
    DateTime _pickedDate = DateTime.now();

    return Container(
      height: 380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kTealColor.withOpacity(0.8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Add a Reminder',
                  style: kDashboardButtonLabelStyle.copyWith(
                      fontSize: 28, color: kScaffoldBackgroundColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                placeholder: 'Title',
                minLines: 1,
                placeholderColor: kLightAmberColor,
                cursorColor: kLightAmberColor,
                focusedOutlineBorder: kLightAmberColor,
                maxLines: 2,
                controller: this._titleTextController,
                onChanged: (value) {
                  _reminder.title = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 210,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kLightAmberColor
                      ),
                      borderRadius: BorderRadius.circular(5.0)
                      ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${Provider.of<ProviderData>(context).pickedTime.hourOfPeriod}:'
                              '${Provider.of<ProviderData>(context).pickedTime.minute} '
                              '${getPeriod(Provider.of<ProviderData>(context).pickedTime.period)}',
                          style: kReminderContainerTextStyle,
                        ),
                      ),
                    ),
                    ),
                  ButtonTheme(
                    minWidth: 20,
                    height: 56,
                    child: RaisedButton(
                      color: kTealColor,
                      onPressed: () async {
                        _pickedTime = await showTimePicker(
                            context: context,
                            initialTime:
                                TimeOfDay.fromDateTime(DateTime.now())
                        );
                        Provider.of<ProviderData>(context, listen: false).updatePickedTime(_pickedTime);
                        _reminder.actualTime = _pickedTime;
                      },
                      child: Icon(
                        FontAwesomeIcons.businessTime,
                        color: kLightAmberColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 210,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: kLightAmberColor
                        ),
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${getMonth(Provider.of<ProviderData>(context).pickedDate.month)}'
                              ' ${Provider.of<ProviderData>(context).pickedDate.day}, '
                              '${Provider.of<ProviderData>(context).pickedDate.year}',
                          style: kReminderContainerTextStyle,
                        ),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 20,
                    height: 56,
                    child: RaisedButton(
                      color: kTealColor,
                      onPressed: () async {
                        _pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019, 1),
                          lastDate: DateTime(2050),
                        );
                        Provider.of<ProviderData>(context, listen: false).updatePickedDate(_pickedDate);
                      },
                      child: Icon(
                        FontAwesomeIcons.calendarDay,
                        color: kLightAmberColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 10.0),
                child: Container(
                  height: 2.0,
                  width: double.infinity,
                  color: kAmberColor,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
              child: ButtonTheme(
                minWidth: double.maxFinite,
                height: 50,
                child: RaisedButton(
                  onPressed: () async {
                    SharedPreferences _prefs = await SharedPreferences.getInstance();
                    _reminder.email = _prefs.get('email');
                    try{
                      await _firestoreReminderService.postOneTimeReminder(_reminder);
                    }
                    catch(e){
                      print(e.toString());
                    }
                    Navigator.pop(context);
                  },
                  color: kLightAmberColor,
                  focusColor: kAmberColor,
                  autofocus: true,
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.calendarPlus,
                        color: kTealColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Confirm',
                            style: kDashboardButtonLabelStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: kTealColor),
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
    );
  }

  _announcementCardForRecurring(context) {}
}
