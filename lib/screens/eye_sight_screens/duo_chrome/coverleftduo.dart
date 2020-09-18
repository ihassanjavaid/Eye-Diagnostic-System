import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome/left_duochrome.dart';
import 'package:flutter/material.dart';

class CoverLeft extends StatelessWidget {
  String rightDCTstatus;
  CoverLeft({this.rightDCTstatus});
  static const String id = "CoverLeft";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    "Please your right eye",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LeftDuochrome(
                                rightDCTstatus: rightDCTstatus,
                              )),
                    );
                  },
                  child: Text("Next"),
                )
              ]),
        ),
      ),
    );
  }
}
