import 'package:cloud_9_client/components/card/service_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/service_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/service_detail_screen.dart';
import 'package:cloud_9_client/screens/set_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProcedureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    Future<void> _getData() async {
      _serviceProvider.fetchServices();
    }

    void showSnackBar(value) {
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
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
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Procedures',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          body: _serviceProvider.isFetchingServiceData
              ? Center(child: CircularProgressIndicator())
              : _serviceProvider.availableServices.isEmpty
                  ? RefreshIndicator(
                      onRefresh: _getData,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                          ),
                          Center(
                            child: NoItemTile(
                                icon: 'assets/icons/procedure.png',
                                title: 'No Procedures',
                                subtitle:
                                    'Please there are no procedures available'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      child: ListView.builder(
                          itemCount: _serviceProvider.availableServices.length,
                          itemBuilder: (context, index) {
                            return ServiceCard(
                              onTapCalender: () {
                                if (_serviceProvider.availableServices[index]
                                    .procedures.isNotEmpty) {
                                } else {
                                  showSnackBar(
                                      'There are no procedures scheduled for this event');
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SetAppointmentScreen(
                                        service: _serviceProvider
                                            .availableServices[index],
                                      ),
                                    ));

                                print(_serviceProvider
                                    .availableServices[index].procedures);
                              },
                              service:
                                  _serviceProvider.availableServices[index],
                              onTapMore: () {
                                print('moreeeee');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceDetailScreen(
                                        service: _serviceProvider
                                            .availableServices[index],
                                      ),
                                    ));
                              },
                            );
                          }),
                      onRefresh: _getData),
        ),
      ),
    ));
  }
}
