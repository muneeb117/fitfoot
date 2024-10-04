import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseConfig {
  static final Completer<FirebaseConfig> _completer =
      Completer<FirebaseConfig>();
  static FirebaseConfig? _instance;

  factory FirebaseConfig() {
    return _instance!;
  }

  FirebaseConfig._();

  static FirebaseAnalytics analytic = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytic);
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static late AndroidNotificationChannel channel;
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await setupFlutterNotifications().whenComplete(() {
      showNotification(message);
    });
  }

  static Future<void> setupFlutterNotifications() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static showNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  static FlutterLocalNotificationsPlugin? fltNotification;

  static Future<FirebaseConfig> initialize() async {
    const fatalError = true;
    FlutterError.onError = (errorDetails) {
      if (fatalError) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        // ignore: dead_code
      } else {
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      return true;
    };
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    if (_instance == null) {
      _instance = FirebaseConfig._();
      try {
        await notificationPermission();
        var androidInit =
            const AndroidInitializationSettings('@mipmap/ic_launcher');
        var iosInit = const DarwinInitializationSettings();
        var initSetting =
            InitializationSettings(android: androidInit, iOS: iosInit);
        fltNotification = FlutterLocalNotificationsPlugin();
        fltNotification?.initialize(initSetting);
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          if (kDebugMode) {
            print("Notification received${message.notification!.toMap()}");
            print("Notification received$message");
          }
          showNotification(message);
        });
      } catch (e, s) {
        if (kDebugMode) {
          print("Inlining notification  $e$s");
        }
      }
      _completer.complete(_instance);
    }
    return _completer.future;
  }

  static notificationPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static logEvent({name, parameters, callOptions}) async {
    await analytic.logEvent(
      name: name,
      parameters: parameters,
      callOptions: callOptions,
    );
  }

  static logScreenView({screenClass, parameters, callOptions}) async {
    await analytic.logScreenView(
      screenClass: screenClass,
      screenName: screenClass,
      parameters: parameters,
      callOptions: callOptions,
    );
  }
}
