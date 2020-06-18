import 'package:cloud_9_client/components/card/service_list_card.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/calender_screen.dart';
import 'package:cloud_9_client/screens/service_detail_screen.dart';
import 'package:flutter/material.dart';

class ServiceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
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
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Services',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ServiceListCard(
                    onViewTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailScreen(
                              service: serviceList[index],
                            ),
                          ));
                    },
                    service: serviceList[index],
                    onBookTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CalenderScreen(),
                      //     ));
                      _showDialog(context);
                    },
                  ),
                );
              }, childCount: serviceList.length),
            )
          ],
        ),
      ),
    ));
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Book Appointment"),
          content: Text("Booking an appointment for?"),
          actions: <Widget>[
            FlatButton(
              color: Colors.deepOrange,
              child: Text(
                "Consultation",
                style: TextStyle(
                    // color: Colors.deepOrange,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _calenderNavigator(context, 'Consultation');
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text(
                "Procedure",
                style: TextStyle(
                    // color: Colors.blue,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _calenderNavigator(context, 'Procedure');
              },
            ),
          ],
        );
      },
    );
  }

  _calenderNavigator(context, appointmentType) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalenderScreen(),
        ));
  }
}
