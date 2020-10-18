import 'package:cloud_9_client/components/card/appointment_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/screens/background.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);

    Future<void> _getData() async {
      _appointmentProvider.fetchAppointments(
          clientId: _authProvider.authenticatedUser.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ServiceListScreen()));
            },
          )
        ],
      ),
      body: _appointmentProvider.isFetchingAppointmentData
          ? Center(child: CircularProgressIndicator())
          : _appointmentProvider.availableAppointments.isEmpty
              ? RefreshIndicator(
                  onRefresh: _getData,
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        NoItemTile(
                            icon: 'assets/icons/calendar.png',
                            title: 'No Consultation',
                            subtitle:
                                'Please there are no available consultation'),
                        Spacer(),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  child: ListView.builder(
                      itemCount:
                          _appointmentProvider.availableAppointments.length,
                      itemBuilder: (context, index) {
                        return AppointmentCard(
                          appointmentListCardOnTap: () {},
                          appointmentMoreOnTap: () {},
                          appointment:
                              _appointmentProvider.availableAppointments[index],
                        );
                      }),
                  onRefresh: _getData),
    );
  }
}
