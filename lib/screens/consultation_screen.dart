import 'package:cloud_9_client/components/card/consultation_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/staff_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/consultation_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _staffProvider = Provider.of<StaffProvider>(context);
    Future<void> _getData() async {
      _staffProvider.fetchdoctors();
      _staffProvider.fetchnurses();
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
                    Icons.clear_all,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                )
              ],
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
            // SliverList(
            //     delegate: SliverChildBuilderDelegate((context, index) {
            //   return Padding(
            //     padding: const EdgeInsets.only(bottom: 10),
            //     child: NurseConsultationCard(
            //       nurse: _staffProvider.availablenurses[index],
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => ConsultationListScreen(
            //                 consultations: _staffProvider
            //                     .availablenurses[index].consultations,
            //               ),
            //             ));
            //       },
            //     ),
            //   );
            // }, childCount: _staffProvider.availablenurses.length))
          ],
          body: _staffProvider.isFetchingDoctorData
              ? Center(child: CircularProgressIndicator())
              : _staffProvider.availabledoctors.isEmpty
                  ? RefreshIndicator(
                      onRefresh: _getData,
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 4,
                            ),
                            NoItemTile(
                                icon: 'assets/icons/procedure.png',
                                title: 'No Consultation',
                                subtitle:
                                    'Please there are no available consultation')
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      child: ListView.builder(
                          itemCount: _staffProvider.availabledoctors.length,
                          itemBuilder: (context, index) {
                            return DoctorConsultationCard(
                              doctor: _staffProvider.availabledoctors[index],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ConsultationListScreen(
                                        consultations: _staffProvider
                                            .availabledoctors[index]
                                            .consultations,
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
