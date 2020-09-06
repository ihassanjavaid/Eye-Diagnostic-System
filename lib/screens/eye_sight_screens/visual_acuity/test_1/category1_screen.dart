import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome_screen.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/near_vision_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

const List<String> images = [
  'assets/images/visiualAcuity/snellens/20/C.svg',
  'assets/images/visiualAcuity/snellens/20/E.svg',
  'assets/images/visiualAcuity/snellens/20/F.svg',
  'assets/images/visiualAcuity/snellens/20/Z.svg',
];

int index;
int score = 0;
String level ="20/20";

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
        child: SvgPicture.asset(
          images[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  },
);

class Category1 extends StatefulWidget {
  static const String id = 'Category1';
  @override
  _Category1State createState() => _Category1State();
}

class _Category1State extends State<Category1> {
  TCardController _controller = TCardController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Visual Acuity'),
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
                      print (score);
                      if (info.direction == SwipDirection.Right) {
                        score++;
                        // if score is less than half+1 images length then the test goes on
                        if(score < images.length-1){
                          print(score);
                        }
                        else if(score >= (images.length)-1 ){
                          print('Test Passed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DuoChrome()),
                          );
                        }
                      } else if (info.direction == SwipDirection.Left) {
                        print('Not recognized');
                        if(index >=(images.length/2)  && score<images.length/2){
                          if(score<1){
                            print("test failed");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NearVision()),
                            );
                          }


                        }

                      }
                    },
                    onBack: (index) {
                      print('Not recognized');
                      print(score);
                    },
                    onEnd: () {
                      if(score<images.length-1){
                        print("test failed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NearVision()),
                        );
                      }
                      else{
                        print("test passed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DuoChrome()),
                        );
                      }
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
