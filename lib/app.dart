import 'package:eye_diagnostic_system/default_route.dart';
import 'package:eye_diagnostic_system/models/provider_data.dart';
import 'package:eye_diagnostic_system/observers/forums_observer.dart';
import 'package:eye_diagnostic_system/observers/assistant_observer.dart';
import 'package:eye_diagnostic_system/observers/reminder_observer.dart';
import 'package:eye_diagnostic_system/splash.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class EyeSee extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //create: (BuildContext context) => ProviderData(),
      providers: [
        ChangeNotifierProvider(create: (context) => AssistantObserver()),
        ChangeNotifierProvider(create: (context) => ReminderObserver()),
        ChangeNotifierProvider(create: (context) => ForumsObserver()),
        /// TODO : Old provider below - Remove it after moving things into providers mentioned above
        ChangeNotifierProvider(create: (context) => ProviderData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eye See',
        theme: kEyeSeeThemeData,
        initialRoute: Splash.id,
        routes: DefaultEyeSeeRoute.DEFAULT_ROUTE,
      ),
    );
  }
}