import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'righteye.dart';
class RuleScreen extends StatefulWidget {
  static const String id = 'rules_screen';

  @override
  _RuleScreenState createState() => _RuleScreenState();
}

class _RuleScreenState extends State<RuleScreen> {

  final int _numPages = 3;
  final int totalPage = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for ( int i = 0 ; i < _numPages ; i++ ){
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? kTealColor : kTealColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

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
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule1.png'),
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule2.png'),
                      ruleBlock('Mobile should be at eye level. Distance should be 2-feet from the mobile',
                          'assets/images/rules/rule3.png'),




                    ],
                  ),
            ),

            FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                _currentPage != _numPages -1 ?
                _pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease
                ) :
                Navigator.popAndPushNamed(context, RightEye.id);
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






