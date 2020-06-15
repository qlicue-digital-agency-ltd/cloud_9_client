

import 'package:cloud_9_client/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud 9',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}