import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meatzy_app/Screen/testfcm_page.dart';

import '../Utils/download_file.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse, BuildContext context) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    // Navigator.pushNamed(context, 'fcm-page',
    //     arguments: {"message": jsonEncode(notificationResponse.payload)});

    // Navigator.push(context, MaterialPageRoute(builder:(context) => TestFcmPage(orderId: notificationResponse.payload, title: title, body: body)))
  }

  Future<void> initNotification(BuildContext context) async {
    // Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios initialization
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestAlertPermission: false,
    //   requestBadgePermission: false,
    //   requestSoundPermission: false,
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    // the initialization settings are initialized after they are setted

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (
      NotificationResponse notificationResponse,
    ) async {
      onDidReceiveNotificationResponse(notificationResponse, context);
    });
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String imgurl,
  }) async {
    final bigPicturePath = await Utils.downloadFile(imgurl, 'Big_Picture');
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
          android: AndroidNotificationDetails('main_channel', 'Main Channel',
              channelDescription: "althaf",

              // color: Colors.green,
              // ledColor: Colors.red,
              // ledOffMs: 5,
              // ledOnMs: 5,
              colorized: true,
              category: AndroidNotificationCategory.alarm,
              importance: Importance.high,
              priority: Priority.high,
              styleInformation: BigPictureStyleInformation(
                  FilePathAndroidBitmap(bigPicturePath),
                  htmlFormatTitle: true,
                  contentTitle: title,
                  htmlFormatContentTitle: true)
              //  BigTextStyleInformation(body,
              //    ),
              // sound: soundtype,
              )),
      // iOS details
      // iOS: IOSNotificationDetails(
      //   sound: 'default.wav',
      //   presentAlert: true,
      //   presentBadge: true,
      //   presentSound: true,
      // ),
    );
  }

///////////////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      handleMessage(context, message);
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showLocalNotification(message);
      }
    });
  }

  // function to show visible notification when app is active
  Future<void> showLocalNotification(RemoteMessage message) async {
    final bigPicturePath = await Utils.downloadFile(
        message.notification!.android!.imageUrl.toString(), 'Big_Picture');

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            styleInformation: BigPictureStyleInformation(
                FilePathAndroidBitmap(bigPicturePath),
                htmlFormatTitle: true,
                contentTitle: message.notification!.title.toString(),
                htmlFormatContentTitle: true)
            //  sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            //  icon: largeIconPath
            );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'order') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TestFcmPage(
                  orderId: message.data['orderid'],
                  title: message.notification!.title.toString(),
                  body: message.notification!.body.toString())));
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
