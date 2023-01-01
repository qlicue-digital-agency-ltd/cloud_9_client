import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/category_provider.dart';
import 'package:cloud_9_client/provider/order_provider.dart';
import 'package:cloud_9_client/provider/post_provider.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/provider/service_provider.dart';
import 'package:cloud_9_client/provider/staff_provider.dart';
import 'package:cloud_9_client/provider/transaction_provider.dart';
import 'package:cloud_9_client/provider/utility_provider.dart';
import 'package:cloud_9_client/provider/weight_care_provider.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';

import 'App.dart';

Future<void> _firebaseMessagingBackgroundHandler(
    Map<String, dynamic> message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message $message');

  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print('Notification data is ');
    print(message['data']);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print('This was a Notification');
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'cloud_9_default_notification_channel', // id
  'Cloud  9 Notifications', // title
  'This channel is used for Cloud 9 Clinic Notifications', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {

  runApp(
      MultiProvider(
        providers: [

          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
          ChangeNotifierProvider(create: (_) => UtilityProvider()),
          ChangeNotifierProvider(create: (_) => AppointmentProvider()),
          ChangeNotifierProvider(create: (_) => AppointmentProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => ServiceProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => TransactionProvider()),
          ChangeNotifierProvider(create: (_) => StaffProvider()),
          ChangeNotifierProvider(create: (_) => WeightCareProvider())
        ],
        child: App(),
      ),
    );
}
