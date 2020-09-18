import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:eye_diagnostic_system/screens/eye_sight_screens/near_vision_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data_file.dart';
import 'dart:io';
import 'coverleft.dart';


const List<String> images = [
  "assets/images/visual_acuity/snellens/200/20C.svg",
  "assets/images/visual_acuity/snellens/200/32D.svg",
  "assets/images/visual_acuity/snellens/200/20F.svg",
  "assets/images/visual_acuity/snellens/200/32L.svg",

  "assets/images/visual_acuity/snellens/160/20C.svg",
  "assets/images/visual_acuity/snellens/160/20E.svg",
  "assets/images/visual_acuity/snellens/160/32L.svg",
  "assets/images/visual_acuity/snellens/160/25O.svg",

  "assets/images/visual_acuity/snellens/125/20C.svg",
  "assets/images/visual_acuity/snellens/125/32D.svg",
  "assets/images/visual_acuity/snellens/125/25T.svg",
  "assets/images/visual_acuity/snellens/125/20Z.svg",

  "assets/images/visual_acuity/snellens/100/20E.svg",
  "assets/images/visual_acuity/snellens/100/32L.svg",
  "assets/images/visual_acuity/snellens/100/32P.svg",
  "assets/images/visual_acuity/snellens/100/25T.svg",


  "assets/images/visual_acuity/snellens/80/20C.svg",
  "assets/images/visual_acuity/snellens/80/32L.svg",
  "assets/images/visual_acuity/snellens/80/25O.svg",
  "assets/images/visual_acuity/snellens/80/25T.svg",

  "assets/images/visual_acuity/snellens/63/20C.svg",
  "assets/images/visual_acuity/snellens/63/20E.svg",
  "assets/images/visual_acuity/snellens/63/20F.svg",
  "assets/images/visual_acuity/snellens/63/32P.svg",

  "assets/images/visual_acuity/snellens/50/20C.svg",
  "assets/images/visual_acuity/snellens/50/32P.svg",
  "assets/images/visual_acuity/snellens/50/25T.svg",
  "assets/images/visual_acuity/snellens/50/20Z.svg",

  "assets/images/visual_acuity/snellens/40/20C.svg",
  "assets/images/visual_acuity/snellens/40/32D.svg",
  "assets/images/visual_acuity/snellens/40/20E.svg",
  "assets/images/visual_acuity/snellens/40/32L.svg",

  "assets/images/visual_acuity/snellens/32/20C.svg",
  "assets/images/visual_acuity/snellens/32/32D.svg",
  "assets/images/visual_acuity/snellens/32/32L.svg",
  "assets/images/visual_acuity/snellens/32/32P.svg",

  "assets/images/visual_acuity/snellens/25/20C.svg",
  "assets/images/visual_acuity/snellens/25/20E.svg",
  "assets/images/visual_acuity/snellens/25/25O.svg",
  "assets/images/visual_acuity/snellens/25/25T.svg",

  "assets/images/visual_acuity/snellens/20/20C.svg",
  "assets/images/visual_acuity/snellens/20/20E.svg",
  "assets/images/visual_acuity/snellens/20/20F.svg",
  "assets/images/visual_acuity/snellens/20/20Z.svg",

];





int count=0;
int score = 0;
int picNum=1;
bool status=false;

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

class RightEye extends StatefulWidget {
  static const String id = 'RightEye';

  @override
  _Category1State createState() => _Category1State();
}

class _Category1State extends State<RightEye> {
  Data1 data = new Data1();
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
                      print("==============================");
                      print(index);
                      print(info.direction);
                      print("Score before");
                      print (score);
                      print("Count before");
                      print(count);
                      print("count after");
                      count++;
                      print(count);
                      print("==============================");

                      if (info.direction == SwipDirection.Right) {

                            score++;
                            picNum++;

                        if(count %4 !=0 && score< 3 ){
                          print("score after");
                          print(score);

                        }

                        else if(count %4 ==0 && score>=3){
                          print("Test Passed");
                          count=1;
                        }
                        else if(count%4==0 && score<3){

                          print('test failed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CoverLeft()),
                          );

                        }


                        /*

                        // if score is less than half+1 images length then the test goes on
                        if(score < 3){
                          print(score);
                        }
                        else if(score >= 3){
                          print('Test Passed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DuoChrome()),
                          );
                        }

                         */

                      } else if (info.direction == SwipDirection.Left) {
                        print('Not recognized');

                          if(count==2 && score<2){
                            print("Test failed");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CoverLeft()),
                            );
                          }
                          else if(count%4==0 && score<3){
                            print('test failed');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CoverLeft()),
                            );

                          }


                        /*
                        if(index >=(images.length/2)  && score<images.length/2){
                          if(score<1){
                            data.rightEyeVAT = level;
                            print("test failed");
                            print(data.rightEyeVAT);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NearVision()),
                            );
                          }

                        }*/

                      }
                    },
                    onBack: (index) {
                      picNum++;
                      print('Not recognized');
                      print(score);
                    },
                    onEnd: () {
                      picNum++;
                      if(count %4 ==0 && score>=3){
                        print("Test Passed");
                        status=true;
                        count=1;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoverLeft()),
                        );

                      }
                      else{
                        print("Failed");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoverLeft()),
                        );
                      }
                      /*

                      if(score<images.length-1){
                        data.rightEyeVAT =level;
                        print("test failed");
                        print(data.rightEyeVAT);
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
                      }*/
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


                              _controller.forward(direction:SwipDirection.Left);
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
