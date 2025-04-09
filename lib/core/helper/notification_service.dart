import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paynow_e_wallet_app/app.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/core/utils/constant/constant.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:paynow_e_wallet_app/env.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:paynow_e_wallet_app/features/notification/presentation/bloc/notification_event.dart';
import 'package:paynow_e_wallet_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? accessToken;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      // announcement: true,
      badge: true,
      // carPlay: true,
      // criticalAlert: true,
      // provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        debugPrint('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        debugPrint('user granted provisional permission');
      }
    } else {
      // appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        debugPrint('user denied permission');
      }
    }
  }

  Future<void> saveFCMToken(String? userId) async {
    String? token = await FirebaseMessaging.instance.getToken();

    if (userId != null && token != null) {
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(userId)
          .update({
        kFCMToken: token,
      });
    }
  }

  String? lastMessageId;
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification == null) {
        return;
      }
      debugPrint('Foreground message id: ${message.messageId}');
      debugPrint('Foreground message received: ${message.notification!.title}');
      if (lastMessageId == message.messageId) {
        return;
      } else {
        lastMessageId = message.messageId;
      }
      if (message.notification != null) {
        scaffoldKey.currentContext!
            .read<NotificationBloc>()
            .add(NewNotificationReceived(type: message.data['type']));

        if (Platform.isAndroid) {
          initLocalNotifications(message);
          showNotification(message);
        }

        if (Platform.isIOS) {
          foregroundMessage();
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint('User tapped on notification (Background/Terminated)');
      handleMessage(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint('Notification received when app was terminated');
        handleMessage(message);
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('Handling background message: ${message.notification?.title}');
    final prefs = SharedPreferencesAsync();
    await prefs.setStringList(cachedNotifications, [
      ...(await prefs.getStringList(cachedNotifications) ?? []),
      json.encode(message.toMap()),
    ]);
  }

  void initLocalNotifications(RemoteMessage message) async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('User tapped on notification');
        handleMessage(message);
      },
    );
  }

  Future<void> showNotification(RemoteMessage message) async {
    if (message.notification == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'paynow_channel', // ID của channel, cần được đặt cố định
      'paynow_e_wallet', // Tên của channel
      channelDescription: 'Wallet app notification channel',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
    );
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> handleMessage(
    RemoteMessage message,
  ) async {
    if (message.data['type'] == NotificationType.friendRequest.name &&
        navigatorObserver.currentRouteName !=
            AppRouteEnum.notificationPage.name) {
      navigatorKey.currentState!.pushNamed(AppRouteEnum.notificationPage.name);
    } else if (message.data['type'] == NotificationType.requestMoney.name &&
        navigatorObserver.currentRouteName != AppRouteEnum.requestsPage.name) {
      navigatorKey.currentState!.pushNamed(AppRouteEnum.requestsPage.name);
    }
  }

  Future<String> getFCMAccessToken() async {
    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final Map<String, dynamic> jsonKeys = {
      "type": Env.type,
      "project_id": Env.projectId,
      "private_key_id": Env.privateKeyId,
      "private_key":
          Env.privateKey.replaceAll(r'\n', '\n').replaceAll(r'\\n', '\n'),
      "client_email": Env.clientEmail,
      "client_id": Env.clientId,
      "auth_uri": Env.authUri,
      "token_uri": Env.tokenUri,
      "auth_provider_x509_cert_url": Env.authProviderX509CertUrl,
      "client_x509_cert_url": Env.clientX509CertUrl,
      "universe_domain": Env.universeDomain
    };

    final client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(jsonKeys), scopes);

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(jsonKeys), scopes, client);

    client.close();

    return credentials.accessToken.data;
  }

  Future<void> sendNotification(
      {required String deviceToken,
      required String title,
      required String body,
      required Map<String, dynamic>? data}) async {
    accessToken ??= await getFCMAccessToken();

    Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data
      },
    };

    final response = await Dio().post(dotenv.env['FCM_URL']!,
        data: jsonEncode(message),
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        }));

    if (response.statusCode == 200) {
      print('notification sent');
    } else {
      print('notification failed');
    }
  }

  Future<String?> getDeviceToken(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(Collection.users.name)
        .doc(userId)
        .get();
    try {
      return snapshot.get(kFCMToken);
    } catch (e) {
      return null;
    }
  }

  Future<void> removeFCMToken(String userId) async {
    await FirebaseFirestore.instance
        .collection(Collection.users.name)
        .doc(userId)
        .update({
      kFCMToken: FieldValue.delete(), // Remove FCM token
    });

    await FirebaseMessaging.instance
        .deleteToken(); // Delete token from local storage
  }
}
