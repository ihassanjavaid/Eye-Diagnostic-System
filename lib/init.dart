import 'package:eye_diagnostic_system/services/firestore_hospitals_service.dart';
import 'package:eye_diagnostic_system/services/firestore_reminder_services.dart';
import 'package:eye_diagnostic_system/services/notification_manager_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin notifsPlugin = FlutterLocalNotificationsPlugin();

Future<void> init() async {
  // Necessary for G-Sign in and some other stuff (db, reminders)
  WidgetsFlutterBinding.ensureInitialized();

  // Necessary if using fonts by google
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  // Necessary for firebase and firestore functionality
  await Firebase.initializeApp();

  // To delete past reminders
  await FirestoreReminderService.deletePastReminders();

  //Database
  /// TODO database
  //DatabaseHelper.instance.database;

  /***
  DO NOT UN-COMMENT THIS
  OTHERWISE, DUPLICATE DATA WILL BE ADDED
  ***/
  // Trigger/Uncomment this function when new hospitals are to be added to firestore
  //await FirestoreHospitalsService.push();

  // Notifications
  NotificationAppLaunchDetails notifLaunch;
  notifLaunch = await notifsPlugin.getNotificationAppLaunchDetails();
  print('Notifications Service: ${notifLaunch.didNotificationLaunchApp}');
  NotificationManager notificationManager = NotificationManager();
  await notificationManager.initNotifications(notifsPlugin);
  //requestIOSPermissions(notifsPlugin);
  notificationManager.initNotifications(notifsPlugin);
}
