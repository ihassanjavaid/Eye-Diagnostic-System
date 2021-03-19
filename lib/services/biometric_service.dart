import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricService {
  final LocalAuthentication auth = LocalAuthentication();
  BiometricSupportState _supportState = BiometricSupportState.UNKNOWN;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;


  Future<bool> isDeviceSupported() async {
    List bios = await auth.getAvailableBiometrics();
    if (bios.isNotEmpty){
      return true;
    }
    return false;
  }

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason:
          'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          );
      if (authenticated){
        return true;
      }
      // else if (!authenticated){
      //   return false;
      // }
      return false;
    }
    on PlatformException
    catch (e) {
      print(e.toString());
      throw(e);
      return false;
    }
  }

  void cancelAuthentication() async {
    await auth.stopAuthentication();
  }

  Future<bool> isBiometricAuthEnabled() async {

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool isEnabled = _prefs.getBool('biometrics');
    if ((isEnabled == null) || !isEnabled){
      return false;
    }
    else if (isEnabled){
      return true;
    }
    return false;
  }

  Future turnOnBiometrics() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('biometrics', true);
  }

  Future turnOffBiometrics() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('biometrics', false);
  }
}