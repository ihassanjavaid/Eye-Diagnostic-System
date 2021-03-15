/*
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  var flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void initNotifications() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void showNotificationDaily(
      int id, String title, String body, int hour, int minute) async {
    var time = new Time(hour, minute, 0);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        id, title, body, time, getPlatformChannelSpecfics());
    print('Notification Succesfully Scheduled at ${time.toString()}');
  }

  getPlatformChannelSpecfics() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'Medicine Reminder');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}*/

import 'package:eye_diagnostic_system/models/notification_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notifs;
import 'package:rxdart/subjects.dart' as rxSub;

class NotificationManager{
  final rxSub.BehaviorSubject<NotificationData>
  didReceiveLocalNotificationSubject =
  rxSub.BehaviorSubject<NotificationData>();
  final rxSub.BehaviorSubject<String> selectNotificationSubject =
  rxSub.BehaviorSubject<String>();

  Future<void> initNotifications(notifs.FlutterLocalNotificationsPlugin notifsPlugin) async {

    var initializationSettingsAndroid =
    notifs.AndroidInitializationSettings('icon');

    var initializationSettingsIOS =
    notifs.IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(NotificationData(
              id: id, title: title, body: body, payload: payload));
        });

    var initializationSettings = notifs.InitializationSettings(android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);

    await notifsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload);
        });
    print("Notifications initialised successfully");
  }

  Future<void> scheduleNotification(
      {notifs.FlutterLocalNotificationsPlugin notifsPlugin,
        String id,
        String title,
        String body,
        DateTime scheduledTime}) async {
    var androidSpecifics = notifs.AndroidNotificationDetails(
      id, // This specifies the ID of the Notification
      'Scheduled notification', // This specifies the name of the notification channel
      'A scheduled notification', //This specifies the description of the channel
      icon: 'icon',
    );
    var iOSSpecifics = notifs.IOSNotificationDetails();
    var platformChannelSpecifics = notifs.NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);
    await notifsPlugin.schedule(0, title, body,
        scheduledTime, platformChannelSpecifics, androidAllowWhileIdle: true); // This literally schedules the notification
  }

}