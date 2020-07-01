import 'package:cloud_9_client/components/card/appointment_card.dart';
import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/service_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
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
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ServiceListScreen()));
                  },
                )
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'My Appointments',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 10),
            ])),
            _appointmentProvider.availableAppointments.length > 0
                ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: AppointmentCard(
                          appointmentListCardOnTap: () {},
                          appointmentMoreOnTap: () {},
                          appointment:
                              _appointmentProvider.availableAppointments[index],
                        ),
                      );
                    },
                        childCount:
                            _appointmentProvider.availableAppointments.length),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate(
                        [SizedBox(height: 10), Text('No appointments')])),
          ],
        ),
      ),
    ));
  }
}
