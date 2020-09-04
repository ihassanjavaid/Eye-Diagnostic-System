import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';


String globalSelectedItem;

class Choice_Chip extends StatefulWidget {
  static final String id = 'forum_user_user_questions';
  @override
  _Choice_ChipState createState() => _Choice_ChipState();
}

class _Choice_ChipState extends State<Choice_Chip> {
  List<String> chipList = [
    "Question",
    "Suggestion",
    "Hospital",
    "Disease",
    "Doctor",
    "Disorder"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build(
      return Container(
        color: Colors.transparent,
          alignment: Alignment.center,
          child: Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            children: <Widget>[
              choiceChipWidget(chipList),
            ],
          ));
  }
}

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: kDashboardButtonLabelStyle.copyWith(color: kDarkPurpleColor, fontSize: 14.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              globalSelectedItem = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}