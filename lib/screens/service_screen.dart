import 'package:cloud_9_client/components/card/category_card.dart';
import 'package:cloud_9_client/components/card/service_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/category_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/service_detail_screen.dart';
import 'package:cloud_9_client/screens/set_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoryProvider = Provider.of<CategoryProvider>(context);
    Future<void> _getData() async {
      _categoryProvider.fetchCategories();
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
                  'Services',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ])),
            SliverToBoxAdapter(
              child: _categoryProvider.availableCategories.length > 0
                  ? SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5, bottom: 5),
                            child: CategoryCard(
                              onTap: () {
                                // _categoryProvider.setSelectedServiceList =
                                //     _categoryProvider
                                //         .availableCategories[index].services;
                                // _categoryProvider.setSelectedCategory =
                                //     _categoryProvider
                                //         .availableCategories[index].id;
                                // _categoryProvider.setSelectedProcedures =
                                //     _categoryProvider
                                //         .availableCategories[index].procedures;
                              },
                              category:
                                  _categoryProvider.availableCategories[index],
                            ),
                          );
                        },
                        itemCount: _categoryProvider.availableCategories.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Container(
                      child: Center(),
                    ),
            )
          ],
          body: _categoryProvider.isFetchingCategoryData
              ? Center(child: CircularProgressIndicator())
              : _categoryProvider.availableServices.isEmpty
                  ? Center(
                      child: NoItemTile(
                          icon: 'assets/icons/procedure.png',
                          title: 'No Procedures',
                          subtitle: 'Please there are no procedures available'),
                    )
                  : RefreshIndicator(
                      child: ListView.builder(
                          itemCount: _categoryProvider.availableServices.length,
                          itemBuilder: (context, index) {
                            return ServiceCard(
                              onTapCalender: () {
                                if (_categoryProvider.availableServices[index]
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
                                        service: _categoryProvider
                                            .availableServices[index],
                                      ),
                                    ));

                                print(_categoryProvider
                                    .availableServices[index].procedures);
                              },
                              service:
                                  _categoryProvider.availableServices[index],
                              onTapMore: () {
                                print('moreeeee');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceDetailScreen(
                                        service: _categoryProvider
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
