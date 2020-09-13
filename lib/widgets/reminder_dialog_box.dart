import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/models/reminder_data.dart';
import 'package:eye_diagnostic_system/services/firestore_reminder_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:eye_diagnostic_system/widgets/reminder_choice_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'custom_textfield.dart';

class ReminderDialog {
  ReminderDialog({@required this.reminderType});

  final ReminderType reminderType;
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
    Reminder _oneTimeReminder = Reminder();
    TimeOfDay _pickedTime= TimeOfDay(hour: 0, minute: 0);
    DateTime _pickedDate = DateTime(2019);

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
                onChanged: (value) {
                  Provider.of<ProviderData>(context, listen: false).updateReminderTitle(value);
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
                        // update provider to show the selected time
                        Provider.of<ProviderData>(context, listen: false).updatePickedTime(_pickedTime);

                        // store data in reminder object for firebase
                       /* _oneTimeReminder.actualTime.hours = _pickedTime.hour;
                        _oneTimeReminder.actualTime.minutes = _pickedTime.minute;*/
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
                        // update provider to show selected date
                        Provider.of<ProviderData>(context, listen: false).updatePickedDate(_pickedDate);

                        // store data in reminder object for firebase
                        /*_oneTimeReminder.actualDate.year = _pickedDate.year;
                        _oneTimeReminder.actualDate.month = _pickedDate.month;
                        _oneTimeReminder.actualDate.day = _pickedDate.day;*/
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
                    // set preferences for one-time reminder
                    _oneTimeReminder.isRecurring = false;
                    _oneTimeReminder.recurrence = 0;
                    // set title
                    _oneTimeReminder.title = Provider.of<ProviderData>(context, listen: false).reminderTitle;
                    // set time
                    _oneTimeReminder.actualTime.hours = Provider.of<ProviderData>(context, listen: false).pickedTime.hour;
                    _oneTimeReminder.actualTime.minutes = Provider.of<ProviderData>(context, listen: false).pickedTime.minute;
                    //set date
                    _oneTimeReminder.actualDate.year = Provider.of<ProviderData>(context, listen: false).pickedDate.year;
                    _oneTimeReminder.actualDate.month = Provider.of<ProviderData>(context, listen: false).pickedDate.month;
                    _oneTimeReminder.actualDate.day = Provider.of<ProviderData>(context, listen: false).pickedDate.day;

                    // store data in firestore
                    try{
                      await _firestoreReminderService.postOneTimeReminder(_oneTimeReminder);
                    }
                    catch(e){
                      AlertWidget()
                          .generateAlert(
                          context: context, title: "Error", description: e.toString())
                          .show();
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

  _announcementCardForRecurring(context) {
    Reminder _recurringReminder = Reminder();
    TimeOfDay _pickedTime= TimeOfDay(hour: 0, minute: 0);
    DateTime _pickedDate = DateTime(2019);

    return Container(
      height: 418,
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
                  'Schedule a Medicine',
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
                onChanged: (value) {
                  Provider.of<ProviderData>(context, listen: false).updateReminderTitle(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 30,
                width: 340,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Up Till:',
                      style: kDashboardButtonLabelStyle.copyWith(
                          fontSize: 18, color: kLightAmberColor),
                    ),
                    Container(
                      height: 2.0,
                      width: 195,
                      color: kAmberColor,
                    ),
                  ],
                ),
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
                        // update provider to show selected date
                        Provider.of<ProviderData>(context, listen: false).updatePickedDate(_pickedDate);

                        // store data in reminder object for firebase
                        /*_oneTimeReminder.actualDate.year = _pickedDate.year;
                        _oneTimeReminder.actualDate.month = _pickedDate.month;
                        _oneTimeReminder.actualDate.day = _pickedDate.day;*/
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 30,
                width: 340,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recurrence:',
                      style: kDashboardButtonLabelStyle.copyWith(
                          fontSize: 18, color: kLightAmberColor),
                    ),
                    Container(
                      height: 2.0,
                      width: 150,
                      color: kAmberColor,
                    ),
                  ],
                ),
              ),
            ),
            // This widget will automatically update recurrence in the provider data
            ReminderChoiceChip(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 10.0),
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
                    // set preferences for one-time reminder
                    _recurringReminder.isRecurring = true;
                    _recurringReminder.recurrence = Provider.of<ProviderData>(context, listen: false).recurrence;
                    // set title
                    _recurringReminder.title = Provider.of<ProviderData>(context, listen: false).reminderTitle;
                    // set date
                    _recurringReminder.actualDate.year = Provider.of<ProviderData>(context, listen: false).pickedDate.year;
                    _recurringReminder.actualDate.month = Provider.of<ProviderData>(context, listen: false).pickedDate.month;
                    _recurringReminder.actualDate.day = Provider.of<ProviderData>(context, listen: false).pickedDate.day;

                    // store data in firestore
                    try{
                      await _firestoreReminderService.postRecurringReminder(_recurringReminder);
                    }
                    catch(e){
                      AlertWidget()
                          .generateAlert(
                          context: context, title: "Error", description: e.toString())
                          .show();
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
}
