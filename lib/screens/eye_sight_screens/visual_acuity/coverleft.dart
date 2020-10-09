import 'package:flutter/material.dart';
import 'left_eye.dart';
class CoverLeft extends StatelessWidget {

  int rightNumber;
  CoverLeft({this.rightNumber});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                     child: Text("Please your right eye",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20

                       ),
                     ),
                   ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LeftEye()),
                      );
                    },
                    child: Text("Next"),
                  )

                ]

              ),
            ),
          ),
        )
    );
  }
}
