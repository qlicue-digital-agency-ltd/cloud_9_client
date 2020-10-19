import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/auth/login_page.dart';
import 'package:cloud_9_client/pages/auth/profile_page.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/screens/home_screen.dart';
import 'package:cloud_9_client/screens/order_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animations/splash/animated_splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      title: 'Cloud 9',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(),
      routes: {
        landingScreen: (BuildContext context) =>
            _authProvider.isAuthenticated && _authProvider.hasUserProfile
                ? HomeScreen()
                : _authProvider.isAuthenticated ? ProfilePage() : LoginPage(),
        homeScreen: (BuildContext context) => HomeScreen(),
        loginScreen: (BuildContext context) => LoginPage(),
        profileScreen: (BuildContext context) => ProfilePage(),
        orderDetailScreen: (BuildContext context) => OrderDetailScreen(),
      },
    );
  }
}
