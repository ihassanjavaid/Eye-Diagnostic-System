import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReminderChoiceChip extends StatefulWidget {
  static final String id = 'forum_user_user_questions';
  @override
  _ReminderChoiceChipState createState() => _ReminderChoiceChipState();
}

class _ReminderChoiceChipState extends State<ReminderChoiceChip> {
  List<String> chipList = [
    'Once',
    'Twice',
    'Thrice'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: <Widget>[
            RemChoiceChipWidget(chipList),
          ],
        ));
  }
}

class RemChoiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  RemChoiceChipWidget(this.reportList);

  @override
  _RemChoiceChipWidgetState createState() => new _RemChoiceChipWidgetState();
}

class _RemChoiceChipWidgetState extends State<RemChoiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(
          Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical:2.0, horizontal: 14.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: kDashboardButtonLabelStyle.copyWith(color: kTealColor, fontSize: 14.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: kScaffoldBackgroundColor,
          selectedColor: kLightAmberColor,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              Provider.of<ProviderData>(context, listen: false).updateRecurrence(getRecurrence(selectedChoice));
            });
          },
        ),
      ));
    });
    return choices;
  }

  int getRecurrence(String timesRecur){
    if ( timesRecur == 'twice' || timesRecur == 'Twice' )
      return 2;
    else if ( timesRecur == 'thrice' || timesRecur == 'Thrice' )
      return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}