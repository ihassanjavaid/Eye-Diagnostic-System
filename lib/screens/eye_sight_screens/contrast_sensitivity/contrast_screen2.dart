import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
import 'contrast_screen3.dart';
class ContrastScreen2 extends StatelessWidget {
  static const String id = 'ContrastScreen2';
  String contQ1,contQ2;

  ContrastScreen2({this.contQ1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            child: ClipPath(
              clipper: HeaderCustomClipper(),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  child: Card(

                    child: Image(
                      image: AssetImage('assets/images/contrast/coffee.gif'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          "Difficulty pouring coffee into a dark mug",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  contQ2 = "often";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContrastScreen3(
                                              contQ1: contQ1,contQ2: contQ2,
                                            )),
                                  );
                                },
                                color: Colors.redAccent,
                                child: Text(
                                  "Often",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  contQ2 = "sometimes";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContrastScreen3(
                                              contQ1: contQ1,contQ2: contQ2,
                                            )),
                                  );
                                },
                                color: Colors.blue,
                                child: Text(
                                  "Sometime",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  contQ2 = "never";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ContrastScreen3(
                                              contQ1: contQ1,contQ2: contQ2,
                                            )),
                                  );
                                },
                                color: Colors.green,
                                child: Text(
                                  "Never",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
