import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'duo_chrome_screen.dart';
class RuleScreen extends StatefulWidget {
  static const String id = 'RuleScreen';

  @override
  _RuleScreenState createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {
  final int totalPage = 4;
  final controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rules"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          children:<Widget> [
            Container(
              height: 500,
              child: PageView(
                onPageChanged:(int page){
                  print(page);
                  _currentPage=page;
                },
                scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule1.png'),
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule2.png'),
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule3.png'),
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule1.png'),



                    ],
                  ),
            ),

            FlatButton(
              color: Colors.blueAccent,
              onPressed: (){

              _currentPage != totalPage -1 ?
              controller.nextPage(duration: Duration(milliseconds: 500),
                  curve: Curves.ease):
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DuoChrome())
              );


            },
              child: Text(_currentPage!= totalPage-1?'Next':'Start'),
            )
          ],
        ),


    );
  }


  Widget ruleBlock(String txt, String path){
    return Padding(
      padding: EdgeInsets.all(5),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
              Text(txt,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
          Padding(padding: EdgeInsets.only(top: 5),
            child: Image(
              height: 400,
              image: AssetImage(path),
            ),
          )
        ],
      ) ,
    );
  }



}






