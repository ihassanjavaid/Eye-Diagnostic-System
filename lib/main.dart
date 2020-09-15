import 'package:eye_diagnostic_system/default_route.dart';
import 'package:eye_diagnostic_system/init.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/services/auto_login_service.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // perform the necessary initializations
  await init();
  // Launch EyeSee
  runApp(EyeSee());
}

class EyeSee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eye See',
        theme: ThemeData(
          backgroundColor: kScaffoldBackgroundColor,
          dialogBackgroundColor: kScaffoldBackgroundColor,
          scaffoldBackgroundColor: kScaffoldBackgroundColor,
        ),
        initialRoute: AutoLoginService.id,
        routes: DefaultEyeSeeRoutes.EYESEE_DEFAULT_ROUTE,
      ),
    );
  }

}