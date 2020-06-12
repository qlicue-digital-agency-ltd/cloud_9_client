import 'package:cloud_9_client/screens/home_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            color: Color(0xfff7f7f7),
          ),
          HomeScreen()
        ]),
      ),
    );
  }
}
