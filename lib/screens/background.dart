import 'package:cloud_9_client/animations/backgroud/home_background_major_clipper.dart';
import 'package:flutter/material.dart';

import 'drawer_sreen.dart';

class Background extends StatelessWidget {
  final Widget screen;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Background({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(children: <Widget>[
          Container(
            color: Colors.blue[200],
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
          screen
        ]),
      ),
      endDrawer: DrawerScreen(),
    );
  }

}
