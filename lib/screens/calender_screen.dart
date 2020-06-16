import 'package:cloud_9_client/components/calender/calender_carousel.dart';

import 'package:cloud_9_client/components/card/calender_card.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Scheduled Appointments',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
              ),
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[],
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.all(16.0),
                color: Colors.blue,
                child: CalendarCarouselCard(),
              ),
              CalenderCard(onTapConfirm: () {}, user: null)
            ])),
          ],
        ),
      ),
    ));
  }
}
