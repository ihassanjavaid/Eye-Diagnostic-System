import 'package:eye_diagnostic_system/screens/eye_sight_screens/duo_chrome/duo_chrome_screen.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data_file.dart';
import 'dart:io';



const List<String> images = [
  "assets/images/visual_acuity/snellens/200C.svg",
  "assets/images/visual_acuity/snellens/200D.svg",
  "assets/images/visual_acuity/snellens/200F.svg",
  "assets/images/visual_acuity/snellens/200L.svg",

  "assets/images/visual_acuity/snellens/160C.svg",
  "assets/images/visual_acuity/snellens/160E.svg",
  "assets/images/visual_acuity/snellens/160L.svg",
  "assets/images/visual_acuity/snellens/160O.svg",

  "assets/images/visual_acuity/snellens/125C.svg",
  "assets/images/visual_acuity/snellens/125D.svg",
  "assets/images/visual_acuity/snellens/125T.svg",
  "assets/images/visual_acuity/snellens/125Z.svg",

  "assets/images/visual_acuity/snellens/100E.svg",
  "assets/images/visual_acuity/snellens/100L.svg",
  "assets/images/visual_acuity/snellens/100P.svg",
  "assets/images/visual_acuity/snellens/100T.svg",


  "assets/images/visual_acuity/snellens/80C.svg",
  "assets/images/visual_acuity/snellens/80L.svg",
  "assets/images/visual_acuity/snellens/80O.svg",
  "assets/images/visual_acuity/snellens/80T.svg",

  "assets/images/visual_acuity/snellens/63C.svg",
  "assets/images/visual_acuity/snellens/63E.svg",
  "assets/images/visual_acuity/snellens/63F.svg",
  "assets/images/visual_acuity/snellens/63P.svg",

  "assets/images/visual_acuity/snellens/50C.svg",
  "assets/images/visual_acuity/snellens/50P.svg",
  "assets/images/visual_acuity/snellens/50T.svg",
  "assets/images/visual_acuity/snellens/50Z.svg",

  "assets/images/visual_acuity/snellens/40C.svg",
  "assets/images/visual_acuity/snellens/40D.svg",
  "assets/images/visual_acuity/snellens/40E.svg",
  "assets/images/visual_acuity/snellens/40L.svg",

  "assets/images/visual_acuity/snellens/32C.svg",
  "assets/images/visual_acuity/snellens/32D.svg",
  "assets/images/visual_acuity/snellens/32L.svg",
  "assets/images/visual_acuity/snellens/32P.svg",

  "assets/images/visual_acuity/snellens/25C.svg",
  "assets/images/visual_acuity/snellens/25E.svg",
  "assets/images/visual_acuity/snellens/25O.svg",
  "assets/images/visual_acuity/snellens/25T.svg",

  "assets/images/visual_acuity/snellens/20C.svg",
  "assets/images/visual_acuity/snellens/20E.svg",
  "assets/images/visual_acuity/snellens/20F.svg",
  "assets/images/visual_acuity/snellens/20Z.svg",
];

String category;
int itr;
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





class LeftEye extends StatefulWidget {
  static const String id = 'LeftEye';
  int rightNumber;
  LeftEye({this.rightNumber});


  @override
  _LeftEyeState createState() => _LeftEyeState();
}


class _LeftEyeState extends State<LeftEye> {

  Data1 data = new Data1();
  TCardController _controller = TCardController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                      //testing start
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
                      //testing end


                      // if a user swipe a card right
                      if (info.direction == SwipDirection.Right) {

                        score++; //increment score because the picture is visible to user
                        picNum++; // increase the pic number that will shown to user

                        if(count %4 !=0 && score< 3 ){
                          //testing start
                          print("score after");
                          print(score);
                          //testing end

                        }
                        // if score is greater then or equal to 3, then the test set is passed
                        else if(count %4 ==0 && score>=3){
                          //testing start
                          print("Test Passed");
                          count=0;
                          score=0;
                        }
                        // if the score is less than 3 system navigate the user to the cover left screen
                        else if(count%4==0 && score<3){

                          print('test failed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DuoChrome()),
                          );

                        }


                        // if direction of swipe is left means the image is not visible to user

                      } else if (info.direction == SwipDirection.Left) {

                        //testing start
                        print("=======================");
                        print('Not recognized');
                        print(count);
                        print(score);
                        //testing end


                        // if third image shown to user and the score is less than 3,means test set failed
                        if(count==3 && score<2){
                          print("Test failed");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DuoChrome()),
                          );
                        }
                        // if the 4 pic of a set is shown to a user and score is less than 3, test set failed
                        else if(count%4==0 && score<3){
                          print('test failed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DuoChrome()),
                          );

                        }

                        // if score is greater then or equal to 3, then the test set is passed
                        else if(count%4==0 && score>3){
                          print("Test Passed");
                          count=0;
                          score=0;
                        }

                      }
                    },
                    onBack: (index) {
                      picNum++;
                      print('Not recognized');
                      print(score);
                    },

                    // the last card
                    onEnd: () {
                      picNum++;
                      if(count %4 ==0 && score>=3){
                        print("Test Passed");
                        status=true;
                        count=1;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DuoChrome()),
                        );

                      }
                      else{
                        print("Failed");
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
