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

    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
             
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
          ],
          body: _appointmentProvider.isFetchingAppointmentData
              ? Center(child: CircularProgressIndicator())
              : _appointmentProvider.availableAppointments.isEmpty
                  ? RefreshIndicator(
                      onRefresh: _getData,
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            Spacer(),
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
                              appointment: _appointmentProvider
                                  .availableAppointments[index],
                            );
                          }),
                      onRefresh: _getData),
        ),
      ),
    ));
  }
}
