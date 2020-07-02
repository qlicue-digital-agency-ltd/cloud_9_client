import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/auth/login_page.dart';
import 'package:cloud_9_client/pages/auth/profile_page.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animations/splash/animated_splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder:
          (BuildContext context, AuthProvider _authProvider, Widget child) =>
              NotificationListener(
        child: FutureBuilder(
          future: Future.wait([_authProvider.autoAuthenticate()]),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              MaterialApp(
            title: 'Cloud 9',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AnimatedSplashScreen(),
            routes: {
              landingScreen: (BuildContext context) =>
                  (snapshot.connectionState == ConnectionState.done)
                      ? _authProvider.isAuthenticated &&
                              _authProvider.hasUserProfile
                          ? HomeScreen()
                          : _authProvider.isAuthenticated
                              ? ProfilePage()
                              : LoginPage()
                      : AnimatedSplashScreen(),
              homeScreen: (BuildContext context) => HomeScreen(),
              loginScreen: (BuildContext context) => LoginPage(),
              profileScreen: (BuildContext context) => ProfilePage(),
            },
          ),
        ),
      ),
    );
  }

  void autoAuth() {
    /// _authProvider.autoAuthenticate();
  }
}
