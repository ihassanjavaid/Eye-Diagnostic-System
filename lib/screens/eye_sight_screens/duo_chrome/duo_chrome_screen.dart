import 'package:flutter/material.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome/coverleftduo.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/data_file.dart';


class DuoChrome extends StatelessWidget {
  static const String id = 'duo_chrome_screen';
  String status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Duo-Chrome Test"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Card(
                child: Image(
              image:
                  AssetImage('assets/images/vision_testing/duochrome_test.png'),
              width: 400,
            )),
            SizedBox(
              height: 20,
              width: 10,
            ),
            Container(
              width: 400,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Which circles are more clear with red-background or with green-background or both are same ?",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
              width: 10,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Row(
                  children: [
                    FlatButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          status = 'short-sightedness';
                          print(status);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoverLeft(
                                      rightDCTstatus: status,
                                    )),
                          );
                        },
                        child: Text(
                          'Red',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          status = 'long-sightedness';
                          print(status);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoverLeft(
                                      rightDCTstatus: status,
                                    )),
                          );
                        },
                        child: Text(
                          'Green',
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          status = 'perfect';
                          print(status);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoverLeft(
                                      rightDCTstatus: status,
                                    )),
                          );
                        },
                        child: Text(
                          'Same',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}