import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/auth/login_page.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/screens/home_screen.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animations/splash/animated_splash_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  SharedPref _pref = SharedPref();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
 
    _pref.readSingleString('token').then((value) {
      print(value);
      if (value != null) {
        setState(() {
          _isAuthenticated = true;
        });
      }
    });
  }

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
        landingScreen: (BuildContext context) =>
            _isAuthenticated ? HomeScreen() : LoginPage(),
        homeScreen: (BuildContext context) => HomeScreen(),
        loginScreen: (BuildContext context) => LoginPage(),
      },
    );
  }

  void autoAuth() {
    /// _authProvider.autoAuthenticate();
  }
}
