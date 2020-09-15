import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChoiceChipWidget extends StatefulWidget {
  static final String id = 'forum_user_user_questions';
  @override
  _ChoiceChipWidgetState createState() => _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
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
          labelStyle: kDashboardButtonLabelStyle.copyWith(color: kTealColor, fontSize: 14.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: kScaffoldBackgroundColor,
          selectedColor: kAmberColor,
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
              Provider.of<ProviderData>(context, listen: false).updateTagData(selectedChoice);
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