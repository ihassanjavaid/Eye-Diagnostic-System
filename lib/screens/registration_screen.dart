import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _rememberMe = false;
  String _name;
  String _email;
  String _password;
  bool _waiting = false;
  Auth _auth = Auth();
  FirestoreUserService _firestoreUserService = FirestoreUserService();

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kLoginBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){
              this._email = value;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kLoginHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kLoginBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value){
              this._name = value;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: kLoginHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: kLoginBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            onChanged: (value){
              this._password = value;
            },
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kLoginHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: GestureDetector(
        onTap:() async{
          setState(() {
            _waiting = true;
          });
          try{
            // register user in Firebase Auth
            await _auth.registerUser(email:removeSpaces(_email), password: _password);
            // register user in Firebase Firestore
            await _firestoreUserService.registerUserInFirebase(displayName: this._name, email: this._email);
            // register user in device locally - shared prefs
            final SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setString('email', removeSpaces(this._email));
            await pref.setString('displayName', this._name);
            // Navigate
            Navigator.popAndPushNamed(context, Dashboard.id);
          }
          catch(e){
            AlertWidget()
                .generateAlert(
                context: context,
                title: "Error",
                description: e.toString()).show();
            print(e);
          }
          setState(() {
            _waiting = false;
          });


        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 30.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 2.0),
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Register with',
            style: kLoginLabelStyle.copyWith(fontSize: 20),
          ),
          SizedBox(
            width: 25.0,
          ),
          GestureDetector(
            onTap: () {
              print("### Sign-in with Google pressed");
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(
                    'assets/logos/google_icon.jpg',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, LoginScreen.id);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String removeSpaces(String email) => email.replaceAll(' ', '');

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _waiting,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: kBgColorGradientArrayBlues,
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, LoginScreen.id);
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child: Image(
                                  image: AssetImage('assets/images/eye.png'),
                                  height: 180.0,
                                  width: 180.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Container(
                            height: 2.0,
                            width: 300.0,
                            color: kGoldenColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0, bottom: 10.0),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0),
                        _buildNameTextField(),
                        SizedBox(height: 30.0),
                        _buildEmailTextField(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTextField(),
                        SizedBox(height: 18.0),
                        _buildRegistrationBtn(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildSignInWithText(),
                        _buildSocialBtnRow(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildSignInBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
