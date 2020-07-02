import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/auth/login_page.dart';
import 'package:cloud_9_client/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'animations/splash/animated_splash_screen.dart';

class App extends StatelessWidget {
  bool _isAuthenticated = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud 9',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(),
      routes: {
        homeScreen: (BuildContext context) =>
            _isAuthenticated ? HomeScreen() : LoginPage(),
      },
    );
  }
}
