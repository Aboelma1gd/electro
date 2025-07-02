import 'dart:convert';
import 'dart:io';
import 'package:electro/features/notifications/data/models/notification_model.dart';
import 'package:electro/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:get_it/get_it.dart';
import 'package:electro/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
  );

  static Future<void> initialize() async {
    print('🔄 Starting notification service initialization...');
    await _requestPermissions();
    await _initializeLocalNotifications();
    await _setupFirebaseMessaging();
    // await testLocalNotification();
    print('✅ Notification service initialized successfully');
  }

  static Future<void> _requestPermissions() async {
    print('🔄 Requesting notification permissions...');
    // Request Firebase Messaging permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ Firebase notification permission granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('⚠️ Provisional notification permission granted');
    } else {
      print(
          '❌ Firebase notification permission denied: ${settings.authorizationStatus}');
    }

    // Request local notification permissions on Android
    if (Platform.isAndroid) {
      try {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            _localNotifications.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidImplementation != null) {
          final bool? granted =
              await androidImplementation.requestNotificationsPermission();
          print('✅ Local notification permission: $granted');
        }
      } catch (e) {
        print('❌ Error requesting local notification permissions: $e');
      }
    }
  }

  static Future<void> _initializeLocalNotifications() async {
    print('🔄 Initializing local notifications...');
    try {
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initSettings =
          InitializationSettings(android: androidSettings);

      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (details) {
          print('✅ Notification clicked: ${details.payload}');
          // You can add navigation here
        },
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      print('✅ Local notifications initialized successfully');
    } catch (e) {
      print('❌ Error initializing local notifications: $e');
    }
  }

  static Future<void> _setupFirebaseMessaging() async {
    print('🔄 Setting up Firebase Messaging...');
    try {
      // Get the current user's ID
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the FCM token
        final token = await _firebaseMessaging.getToken();
        if (token != null) {
          // Save the token to Firestore
          await _firestore.collection('user_tokens').doc(user.uid).set({
            'token': token,
            'email': user.email,
            'updatedAt': FieldValue.serverTimestamp(),
          });
          print('✅ FCM token saved for user: ${user.uid}');
        }
      }

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await _firestore.collection('user_tokens').doc(user.uid).set({
            'token': newToken,
            'email': user.email,
            'updatedAt': FieldValue.serverTimestamp(),
          });
          print('✅ FCM token refreshed for user: ${user.uid}');
        }
      });

      // Listen for messages when app is in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('📩 Received notification in foreground:');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');

        _showLocalNotification(message);

        final notification = NotificationModel(
          title: message.notification?.title ?? 'No Title',
          body: message.notification?.body ?? 'No Content',
          timestamp: DateTime.now(),
        );

        print('🔔 Attempting to add notification to NotificationsCubit...');
        try {
          sl<NotificationsCubit>().addNotification(notification);
          print('✅ Successfully added notification to NotificationsCubit');
        } catch (e) {
          print('❌ Error adding notification to NotificationsCubit: $e');
        }
      });

      // Listen for notification clicks when app is in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('🔄 App opened from notification:');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');
        // You can add navigation here
      });

      // Handle notifications that open the app from terminated state
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('🔄 App opened from notification when terminated:');
        print('Title: ${initialMessage.notification?.title}');
        print('Body: ${initialMessage.notification?.body}');
        print('Data: ${initialMessage.data}');
      }

      // Subscribe to topic for broadcast notifications
      await _firebaseMessaging.subscribeToTopic('all_users');
      print('✅ Subscribed to topic: all_users');

      print('✅ Firebase Messaging setup successfully');
    } catch (e) {
      print('❌ Error setting up Firebase Messaging: $e');
    }
  }

  static Future<void> _showLocalNotification(RemoteMessage message) async {
    print('🔄 Displaying local notification...');
    try {
      if (message.notification == null) {
        print('⚠️ Notification content not found');
        return;
      }

      await _localNotifications.show(
        DateTime.now().millisecond,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.data),
      );
      print('✅ Local notification displayed successfully');
    } catch (e) {
      print('❌ Error displaying local notification: $e');
    }
  }

  static Future<void> checkTopicSubscription() async {
    try {
      print('🔄 Checking topic subscription...');
      await _firebaseMessaging.subscribeToTopic('all_users');
      print('✅ Subscribed to topic: all_users');
    } catch (e) {
      print('❌ Failed subscribing to topic: $e');
    }
  }

  // Method to send notification to a specific user
  static Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      // Get the user's FCM token
      final tokenDoc =
          await _firestore.collection('user_tokens').doc(userId).get();
      final token = tokenDoc.data()?['token'] as String?;

      if (token == null) {
        print('❌ No FCM token found for user: $userId');
        return;
      }

      // Create the notification payload
      final payload = {
        'to': token,
        'notification': {
          'title': title,
          'body': body,
        },
        'data': data ?? {},
      };

      // Send the notification using Firebase Cloud Functions
      // Note: You'll need to implement this Cloud Function
      await _firestore.collection('notifications').add({
        'userId': userId,
        'title': title,
        'body': body,
        'data': data,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
        'payload': payload,
      });

      print('✅ Notification queued for user: $userId');
    } catch (e) {
      print('❌ Error sending notification: $e');
    }
  }

  // Add this method to subscribe a user to a topic
  static Future<void> subscribeUserToTopic(String userId) async {
    try {
      await _firebaseMessaging.subscribeToTopic('user_$userId');
      print('✅ User subscribed to topic: user_$userId');
    } catch (e) {
      print('❌ Error subscribing to topic: $e');
    }
  }

  // Add this method to unsubscribe a user from a topic
  static Future<void> unsubscribeUserFromTopic(String userId) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic('user_$userId');
      print('✅ User unsubscribed from topic: user_$userId');
    } catch (e) {
      print('❌ Error unsubscribing from topic: $e');
    }
  }
}
