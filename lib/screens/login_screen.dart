import 'package:eye_diagnostic_system/models/user_data.dart';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/screens/registration_screen.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  UserData _userData;
  bool _rememberMe = false;
  Auth _auth = Auth();
  bool _waiting = false;
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

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 22.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: kGoldenColor,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.5),
            child: Text(
              'Keep me signed in',
              style: kLoginLabelStyle.copyWith(color: kGoldenColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            _waiting = true;
          });
          try {
            final SharedPreferences pref =
                await SharedPreferences.getInstance();
            await _auth.loginUserWithEmailAndPassword(
                email: removeSpaces(this._email), password: this._password);
            if (_rememberMe) {
              await pref.setString('email', removeSpaces(this._email));
            }
            /*
            * Set name always in shared prefs
            * so that if remember is checked, it is saved in shared prefs
            * if remember be is not checked, the name is saved, and overwritten by next time sign-in
            */
            _userData = await _firestore.getUserData(email: _email);
            await pref.setString('displayName', _userData.displayName);
            /* Set UID in shared prefs so that it can be accessed in community forums*/

            _fbuser = await _auth.getCurrentUser();
            await pref.setString('uid', _fbuser.uid);
            //  Navigate
            Navigator.popAndPushNamed(context, Dashboard.id);
          } catch (e) {
            AlertWidget()
                .generateAlert(
                    context: context,
                    title: 'Invalid Credentials!',
                    description: e.toString())
                .show();
            print(e);
          }
          setState(() {
            _waiting = false;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text('Log In',
                  style: kBottomNavBarTextStyle.copyWith(fontSize: 22.0)),
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

  Widget _buildORText() {
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

  Widget _buildGSignIn() {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign in with',
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
                Navigator.popAndPushNamed(context, Dashboard.id);
              } catch (e) {
                AlertWidget()
                    .generateAlert(
                        context: context,
                        title: 'Sign In Error!',
                        description: 'Google Sign in Failed. Please Try Again.')
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RegistrationScreen.id);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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

  String removeSpaces(String email) {
    if (email == null) return 'null';
    return email.replaceAll(' ', '');
  }

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
                        Container(
                          child: Image(
                            image: AssetImage('assets/images/eye.png'),
                            height: 180.0,
                            width: 180.0,
                          ),
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
                          child: Text('Sign In',
                              style: kBottomNavBarTextStyle.copyWith(
                                  fontSize: 30.0)),
                        ),
                        SizedBox(height: 18.0),
                        _buildEmailTextField(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTextField(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildRememberMeCheckbox(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildLoginBtn(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildORText(),
                        _buildGSignIn(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildSignupBtn(),
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
