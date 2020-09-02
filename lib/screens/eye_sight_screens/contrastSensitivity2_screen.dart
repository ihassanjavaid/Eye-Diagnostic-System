import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'duo_chrome_screen.dart';

List<String> images = [
  'images/nearvision15.png',
  'images/nearvision18.png',
  'images/nearvision13.png',
  'images/nearvision11.png',
];

int index;

List<Widget> cards = List.generate(
  images.length,
  (int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23.0,
            spreadRadius: -13.0,
            color: Colors.black54,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          images[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  },
);

class ContrastSensitivity2 extends StatefulWidget {
  static const String id = 'ContrastSensitivity2_screen';
  @override
  _ContrastSensitivity2State createState() => _ContrastSensitivity2State();
}

class _ContrastSensitivity2State extends State<ContrastSensitivity2> {
  TCardController _controller = TCardController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Near Vision'),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  child: TCard(
                    cards: cards,
                    controller: _controller,
                    onForward: (index, info) {
                      print(index);
                      print(info.direction);
                      if (info.direction == SwipDirection.Right) {
                        print('Test Passed');
                      } else if (info.direction == SwipDirection.Left) {
                        print('Test Failed');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DuoChrome()),
                        );
                      }
                    },
                    onBack: (index) {
                      print('Test Failed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DuoChrome()),
                      );
                    },
                    onEnd: () {
                      print('end');
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 20,
                            textColor: Colors.white,
                            color: Colors.red,
                            onPressed: () {
                              print(_controller);
                              print(_controller.index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DuoChrome()),
                              );
                            },
                            child: Text("not Visible"),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 20,
                            textColor: Colors.white,
                            color: Colors.green,
                            onPressed: () {
                              _controller.forward();
                            },
                            child: Text('Visible'),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
