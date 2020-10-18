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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';

void main() => runApp(
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
        ],
        child: App(),
      ),
    );
