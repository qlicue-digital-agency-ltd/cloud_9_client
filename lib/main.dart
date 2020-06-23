import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: App(),
      ),
    );
