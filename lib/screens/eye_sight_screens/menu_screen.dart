import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'duo_chrome_screen.dart';

class Menu extends StatelessWidget {
  static const String id = 'vision_testing_menu_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vision Tests"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Select test you want to perform",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DuoChrome()),
                  );
                },
                child: Container(
                  width: 100,
                  child: Card(
                    elevation: 20,
                    child: Image(
                      image: AssetImage('assets/images/menu1.png'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 100,
                  child: Card(
                    elevation: 20,
                    child: Image(
                      image: AssetImage('assets/images/menu2.png'),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 100,
                  child: Card(
                    elevation: 20,
                    child: Image(
                      image: AssetImage('assets/images/menu3.png'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
