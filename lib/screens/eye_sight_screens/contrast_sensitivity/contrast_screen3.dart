import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eye_diagnostic_system/components/header_clipper_component.dart';
class ContrastScreen3 extends StatelessWidget {
  static const String id = 'ContrastScreen2';
  String contQ1,contQ2,contQ3;
  ContrastScreen3({this.contQ1,this.contQ2});



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

              children: [
                Container(
                  child: Card(
                    child: Image(
                      image: AssetImage('assets/images/contrast/reading.gif'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: 200,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Eyes easily tired while reading",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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
                                  contQ3 = "often";
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
                                  contQ3 = "sometimes";
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
                                  contQ3 = "never";
                                  print(contQ3);

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





