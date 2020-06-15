import 'package:cloud_9_client/animations/backgroud/home_background_major_clipper.dart';
import 'package:cloud_9_client/screens/service_screen.dart';

import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            color: Color(0xfff7f7f7),
          ),
          ClipPath(
            clipper: HomeBackgroundMajorClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue[700], Colors.blue[200]],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
          ),
          ServiceScreen()
        ]),
      ),
    );
  }
}
