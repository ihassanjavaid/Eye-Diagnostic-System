import 'package:flutter/material.dart';

class UserQuestions extends StatefulWidget {
  static final String id = 'forum_user_user_questions';
  @override
  _UserQuestionsState createState() => _UserQuestionsState();
}

class _UserQuestionsState extends State<UserQuestions> {
  List<String> chipList = [
    "Recycled",
    "Vegetarian",
    "Skilled",
    "Energetic",
    "Friendly",
    "Luxurious"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
               child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: <Widget>[
                        choiceChipWidget(chipList),
                      ],
                    )),
        );
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
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
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