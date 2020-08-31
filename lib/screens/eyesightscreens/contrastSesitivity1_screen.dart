import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'duo_chrome_screen.dart';

class ContrastSensitivity extends StatefulWidget {
  static const String id = 'ContrastSensitivity';
  @override
  _ContrastSestivityState createState() => _ContrastSestivityState();
}

class _ContrastSestivityState extends State<ContrastSensitivity> {
  String q1, q2, q3, q4, q5;

  List<String> _status = ["Often", "Sometimes", "Never"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contrast Sensitivity"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 150,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Problems driving in the rain or at night",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: q1,
                      onChanged: (value) => setState(() {
                        q1 = value;
                        print(q1);
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 150,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Difficulty pouring coffee into a dark mug",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: q2,
                      onChanged: (value) => setState(() {
                        q2 = value;
                        print(q2);
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 150,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Difficulty walking down steps",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: q3,
                      onChanged: (value) => setState(() {
                        q3 = value;
                        print(q3);
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 150,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Focusing on reading instructions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: q4,
                      onChanged: (value) => setState(() {
                        q4 = value;
                        print(q4);
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              height: 150,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Eyes easily tiring while reading or watching television",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: q5,
                      onChanged: (value) => setState(() {
                        q5 = value;
                        print(q5);
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(1),
                child: Container(
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 20,
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DuoChrome()),
                      );
                    },
                    child: Text("Submit"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
