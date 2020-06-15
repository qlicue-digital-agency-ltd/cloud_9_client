import 'package:cloud_9_client/components/calender/calender_carousel.dart';
import 'package:cloud_9_client/components/card/appointment_card.dart';
import 'package:cloud_9_client/pages/cart_page.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
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
              Text(
                'Scheduled Appointments',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 10),
               Container(
                margin: EdgeInsets.all(16.0),
                color: Color(0xff465466),
                child: CalendarCarouselCard(),
              ),
              
            ])),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AppointmentCard(
                    appointmentListCardOnTap: () {
                      print('----------ppppppp-----');
                    },
                    appointmentMoreOnTap: () {
                      print('---object-------');
                    },
                  ),
                );
              }, childCount: 5),
            )
          ],
        ),
      ),
    );
  }
}
