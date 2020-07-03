import 'package:cloud_9_client/components/card/consultation_list_card.dart';
import 'package:cloud_9_client/models/consultation.dart';
import 'package:cloud_9_client/models/service.dart';

import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/calender_screen.dart';
import 'package:cloud_9_client/screens/service_detail_screen.dart';
import 'package:flutter/material.dart';

class ConsultationListScreen extends StatelessWidget {
  final List<Consultation> consultations;

  const ConsultationListScreen({Key key, @required this.consultations})
      : super(key: key);
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
                  'Consultation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ConsultationListCard(
                    onViewTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailScreen(
                              service: Service(
                                  id: 1,
                                  title: 'the title',
                                  body: 'the bofy',
                                  categoryId: 1),
                            ),
                          ));
                    },
                    consultation: consultations[index],
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
              }, childCount: consultations.length),
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
