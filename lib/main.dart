import 'package:electro/electro.dart';
import 'package:electro/features/payments/payment_keys.dart';
import 'package:electro/firebase_options.dart';
import 'package:electro/injection.dart';
import 'package:electro/local_storage.dart';
import 'package:electro/messaging_config.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize only essential services before app launch
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive for local storage
  await HiveHelper.initHive();

  // Initialize basic app dependencies
  init();

  // Run the app immediately
  runApp(const Electro());

  // Initialize non-critical services after app launch
  _initializeNonCriticalServices();
}

Future<void> _initializeNonCriticalServices() async {
  try {
    // Initialize notifications in background
    _initializeNotifications();

    // Initialize Stripe
    Stripe.publishableKey = ApiKeys.publisibleKey;
  } catch (e) {
    print('Error initializing non-critical services: $e');
  }
}

Future<void> _initializeNotifications() async {
  try {
    // Initialize notifications service
    print('Initializing notifications...');
    await NotificationService.initialize();
    print('Notifications initialized successfully');
  } catch (e) {
    print('Error initializing notifications: $e');
  }
}
