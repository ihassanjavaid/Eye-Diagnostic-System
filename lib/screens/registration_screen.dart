import 'package:eye_diagnostic_system/models/user_data.dart';
import 'package:eye_diagnostic_system/screens/login_screen.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loading_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _name;
  String _email;
  String _password;
  Auth _auth = Auth();
  FirestoreUserService _firestoreUserService = FirestoreUserService();
  FirestoreUserService _firestore = FirestoreUserService();
  User _fbuser;
  String _uid;

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
            onChanged: (value) {
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
            onChanged: (value) {
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
            onChanged: (value) {
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
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>LoadingScreen(
            name: this._name,
            email: this._email, password: this._password,
            fbUser: this._fbuser,
            firestoreUserService: this._firestore, auth: this._auth,
            loadingType: LoadingType.SIGNUP,
          )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Register',
                  style: kBottomNavBarTextStyle.copyWith(fontSize: 22.0)),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: kTealColor,
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

  Widget _buildGSignUp() {
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
            onTap: () async {
              try {
                await _auth.signInWithG();
                _fbuser = await _auth.getCurrentUser();
                _uid = _fbuser.uid;
                final SharedPreferences pref =
                    await SharedPreferences.getInstance();

                await pref.setString('uid', _uid);
                await pref.setString('email', _fbuser.email);
                await pref.setString('displayName', _fbuser.displayName);
                UserData userforcheck = await _firestore.getUserData(email:_fbuser.email);
                if (userforcheck == null) {
                  await _firestore.registerUserInFirebase(displayName: _fbuser.displayName, email: _fbuser.email);
                }
                Navigator.pushReplacementNamed(context, Dashboard.id);
              } catch (e) {
                AlertWidget()
                    .generateAlert(
                    context: context,
                    title: 'Sign Up Error!',
                    description: 'Google Sign Up Failed. Please Try Again.')
                    .show();
                print(e);
              }
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
                // image: DecorationImage(
                //   image: AssetImage(
                //     'assets/logos/google_icon.jpg',
                //   ),
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset('assets/logos/google_icon.svg'),
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
        Navigator.popAndPushNamed(context, LoginScreen.id);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: kTealColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: kAmberColor,
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
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                color: kScaffoldBackgroundColor,
                height: double.infinity,
                width: double.infinity,
                /*decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: kBgColorGradientArrayBlues,
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),*/
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
                                style: kBottomNavBarTextStyle,
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
                        padding:
                            const EdgeInsets.only(top: 28.0, bottom: 10.0),
                        child: Text('Sign Up',
                            style: kBottomNavBarTextStyle.copyWith(
                                fontSize: 30.0)),
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
                      _buildGSignUp(),
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
    );
  }
}
