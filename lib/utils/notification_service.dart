import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class local_notification_service {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  static void initialize(){

    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iosInitializationSetting = DarwinInitializationSettings();


    var initializationsSettings = InitializationSettings(android: androidInitialize,
        iOS: iosInitializationSetting
    );

    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }


  static void createNotification(RemoteMessage message) async {

    try {

      AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
        'fcm_default_channel',
        'high_importance_channel',

        playSound: true,
        // sound: RawResourceAndroidNotificationSound('notification'),
        importance: Importance.max,
        priority: Priority.high,
      );
      const iosNotificatonDetail = DarwinNotificationDetails();
      var not= NotificationDetails(android: androidPlatformChannelSpecifics,
          iOS: iosNotificatonDetail

      );


      //  print('title :${message.notification!.body}');
      //  print('body :${message.notification!.title}');
      // print('notificationDetails :$notificationDetails');
      await flutterLocalNotificationsPlugin.show(0, message.notification!.title, message.notification!.body, not,
        // payload:
      );

    }on Exception catch (e) {

      print(e);


    }
  }
}