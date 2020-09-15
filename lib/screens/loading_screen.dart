import 'package:eye_diagnostic_system/models/user_data.dart';
import 'package:eye_diagnostic_system/services/auth_service.dart';
import 'package:eye_diagnostic_system/services/firestore_user_services.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:eye_diagnostic_system/widgets/alert_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_dashboard_screen.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  final String name;
  final String email;
  final String password;
  final Auth auth;
  final bool rememberMe;
  UserData userData;
  final FirestoreUserService firestoreUserService;
  User fbUser;
  final LoadingType loadingType;

  LoadingScreen({this.name, this.email, this.password, this.auth,
  this.rememberMe, this.userData, this.firestoreUserService, this.fbUser,
  this.loadingType});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    if (widget.loadingType == LoadingType.SIGNIN) {
      waitForLogIn();
    }
    else if (widget.loadingType == LoadingType.SIGNUP){
      waitForRegistration();
    }
  }

  String removeSpaces(String email) {
    if (email == null) return 'null';
    return email.replaceAll(' ', '');
  }

  Future<void> waitForLogIn() async {
    try {
      final SharedPreferences pref =
          await SharedPreferences.getInstance();
      await widget.auth.loginUserWithEmailAndPassword(
          email: removeSpaces(widget.email), password: widget.password);
      if (widget.rememberMe) {
        await pref.setString('email', removeSpaces(widget.email));
      }
      /*
            * Set name always in shared prefs
            * so that if remember is checked, it is saved in shared prefs
            * if remember be is not checked, the name is saved, and overwritten by next time sign-in
            */
      widget.userData = await widget.firestoreUserService.getUserData(email: widget.email);
      await pref.setString('displayName', widget.userData.displayName);
      /* Set UID in shared prefs so that it can be accessed in community forums*/

      widget.fbUser = await widget.auth.getCurrentUser();
      await pref.setString('uid', widget.fbUser.uid);
      // Pop all the previous screens
      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      // Navigate to the main screen
      Navigator.pushNamed(context, Dashboard.id);
    } catch (e) {
      AlertWidget()
          .generateAlert(
          context: context,
          title: 'Invalid Credentials!',
          description: e.toString())
          .show();
      print(e);
    }
  }

  Future<void> waitForRegistration() async {
    try {
      // register user in Firebase Auth
      await widget.auth.registerUser(
          email: removeSpaces(widget.email), password: widget.password);
      // register user in Firebase Firestore
      await widget.firestoreUserService.registerUserInFirebase(
          displayName: widget.name, email: widget.email);
      // register user in device locally - shared prefs
      final SharedPreferences pref =
      await SharedPreferences.getInstance();
      await pref.setString('email', removeSpaces(widget.email));
      await pref.setString('displayName', widget.name);
      // Pop all the previous screens
      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      // Navigate to the main screen
      Navigator.pushNamed(context, Dashboard.id);
    } catch (e) {
      AlertWidget()
          .generateAlert(
          context: context, title: "Error", description: e.toString())
          .show();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      body: Center(
        child: SpinKitChasingDots(
          color: kTealColor,
          size: 80.0,
        ),
      ),
    );
  }
}
